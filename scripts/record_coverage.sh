#!/bin/bash -ueo pipefail

# Record coverage
#
# This script uses the Circle and Github APIs to poke a comment into a PR about test coverage.
#
# To work, the GITHUB_TOKEN and CIRCLE_TOKEN vars must be in the environment,
# with appropriate API tokens from GH and Circle.
#
# Also to get the magic link to your  test coverage, you'll want to store the
# `coverage/` directory.
#```
#  - store_artifacts:
#     path: coverage
#```

CURL_ARGS="-s -S -f"

function graceful_exit() {
  echo "*** Something failed!  Exiting gracefully so the build doesn't fail overall"
  exit 0
}

#
# Wrapper for the Github GraphQL API
#
function gh_query() {
  # Build and escape our JSON
  json=$(jq -n --arg q "$*" '{query: $q}')
  curl $CURL_ARGS -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "$json" https://api.github.com/graphql
}


# Trap any fails, and force a successful exit.
trap graceful_exit ERR

last_run=coverage/.last_run.json
if ! [ -s $last_run ] ; then
  echo "*** No $last_run file found."
  exit 0
fi

which jq > /dev/null || sudo apt-get install -y jq

# This is the message that makes it into github
msg="* CircleCI build [#${CIRCLE_BUILD_NUM}](${CIRCLE_BUILD_URL})\n"
msg="$msg* Test coverage: "

# Check to see if coverage is under `result.line` or under `result.covered_percent` (older versions)
coverage=$(jq -r 'if .result.line then .result.line else .result.covered_percent end' < coverage/.last_run.json)

if [ "${coverage}" = "null" ] ; then
  echo "*** Failed to determine coverage"
  exit 0
fi

artifacts_response=$(curl $CURL_ARGS -H "Circle-Token: $CIRCLE_API_TOKEN" https://circleci.com/api/v1.1/project/gh/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/${CIRCLE_BUILD_NUM}/artifacts)
coverage_url=$(echo ${artifacts_response} | jq -r '. | map(select(.path == "coverage/index.html"))[0].url')

if ! [ "${coverage_url}" = "null" ] ; then
  msg="$msg [$coverage%]($coverage_url)\n"
else
  msg="$msg $coverage%\n\n"
  msg="$msg > CircleCI didn't store the Simplecov index (maybe the store_artifacts step is missing?)"
fi

# Find associated PR.  *NB* we're assuming that the first, open PR is the one
# to comment on.
q="query {
  repository(name: \"${CIRCLE_PROJECT_REPONAME}\", owner: \"${CIRCLE_PROJECT_USERNAME}\") {
    ref(qualifiedName: \"${CIRCLE_BRANCH}\") {
      associatedPullRequests(first: 1) {
        nodes {
          id
        }
      }
    }
  }
}"

pr_response=$(gh_query $q)
pr_node=$(echo $pr_response | jq -r ".data.repository.ref.associatedPullRequests.nodes[0].id")

if [ "$pr_node" = "null" ] ; then
  echo "*** No PR found"
  exit 0
fi


echo ">>> Posting code coverage comment"
m="mutation {
  addComment(input: {
    subjectId: \"${pr_node}\",
    body: \"${msg}\"
  }) {
    subject {
      id
    }
  }
}"

gh_query $m

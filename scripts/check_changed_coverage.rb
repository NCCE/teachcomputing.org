# rubocop:disable all

output = `cat /home/circleci/project/coverage/index.html | grep Changed -A 2 | grep "[0-9\.]*%"`
percentage_match = output.match(/([0-9.]+)%/)

raise 'Unable to determine test coverage change at:' unless percentage_match

RED = "\033[0;31m".freeze
BOLD = "\033[1m".freeze
NO_COLOR = "\033[0m".freeze

percentage = percentage_match[0].to_f
if percentage < 90
  warn "\n"
  warn "#{RED}#{BOLD}⚠️  📉  INSUFFICIENT TEST COVERAGE#{NO_COLOR} 📉  ⚠️"
  warn "\n"
  warn "New and changed files need a test coverage of >= 90% -- Simplecov only detected #{RED}#{BOLD}#{percentage}#{NO_COLOR} 😱"
  warn "\n"
  warn 'Changed files:'
  warn " * #{`git diff --name-only origin/master`.split("\n").join("\n * ")}"
  warn "\n"
  exit 1
end

puts "Test coverage for changed files: #{percentage}"

output = `cat #{ENV['CIRCLE_ARTIFACTS']}~/coverage/index.html | grep "[0-9\.]*%"`
percentage_match = output.match(/([0-9.]+)%/)

if percentage_match.nil?
  puts 'No changes to check'
  exit 0
end

raise 'Unable to determine test coverage change' unless percentage_match

percentage = percentage_match[0].to_f
if percentage < 90
  warn '\n'
  warn 'INSUFFICIENT TEST COVERAGE'
  warn '\n'
  warn "New and changed files need a test coverage of >= 90% -- Simplecov only detected #{percentage}"
  warn '\n'
  warn 'Changed files:'
  warn " * #{`git diff --name-only origin/master`.split("\n").join("\n * ")}"
  warn '\n'
  exit 1
end

puts "Test coverage for changed files: #{percentage}"

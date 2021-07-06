file = 'coverage/index.html'

output = `[ -r "#{file}" ] && cat #{file} | grep Changed -A 4 | grep "[0-9\.]*%"`
percentage_match = output.match(/([0-9.]+)%/)

if percentage_match.nil?
  puts 'No changes to check'
  exit 0
end

raise 'Unable to determine test coverage change' unless percentage_match

current_branch = `git rev-parse --abbrev-ref HEAD`
percentage = percentage_match[0].to_f
if percentage < ENV['SIMPLECOV_MIN_COVERAGE']
  warn "Coverage was #{percentage}%, expected at least 90% \n"
  warn 'Changed files:'
  warn " * #{`git diff --name-only master...#{current_branch}`.split("\n").join("\n * ")} \n"
  exit 1
end

puts "Test coverage for changed files: #{percentage}"

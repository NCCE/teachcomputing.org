file = "coverage/.last_run.json"

output = `[ -r "#{file}" ] && cat #{file} | grep "[0-9\.]*"`
percentage_match = output.match(/([0-9.]+)/)

if percentage_match.nil?
  puts "Nothing to check"
  exit 0
end

raise "Unable to determine test coverage change" unless percentage_match

percentage = percentage_match[0].to_f
if percentage < ENV["SIMPLECOV_MIN_COVERAGE"].to_i
  warn "Coverage was #{percentage}%, expected at least 90% \n"
  exit 1
end

puts "Test coverage: #{percentage}%"

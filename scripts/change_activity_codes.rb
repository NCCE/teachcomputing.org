def help_message
  puts <<~HELP
    #{$0} changes the activity codes of a list of courses

    USAGE:
      bin/rails/runner #{$0} PATH_TO_TSV_FILE

    PATH_TO_TSV_FILE
      A tab-separated file with 2 columns
      Column 1 - the stem_course_template_no
      Column 2 - the stem_activity_code

      Script changes the activity code of the matching course to the string in column 2

      Saves a temporary file so you can revert the change.
  HELP
  exit
end

def change_codes(path)
  undo_file = File.open("#{Rails.root}/tmp/change_activity_codes_undo_data_#{Time.now.utc.iso8601}.tsv", "a")
  undo_data = CSV.new(undo_file, col_sep: "\t")

  puts "Reading from TSV file #{path}"

  row_count, update_count = 0, 0

  CSV.foreach(path, col_sep: "\t") do |row|
    row_count += 1

    puts "Row #{row_count}: looking for '#{row.first}'"
    activity = Activity.find_by(stem_course_template_no: row.first.strip)

    unless activity
      puts "#{row.first} not found."
      next
    end

    undo_data << [activity.stem_course_template_no, activity.stem_activity_code]
    puts "Row #{row_count}: Updating activity code of #{activity.stem_course_template_no} from #{activity.stem_activity_code} to #{row.second}"
    activity.update!(stem_activity_code: row.second)
    update_count += 1
  end
rescue => e
  raise e
  puts "\nProcess failed."
ensure
  puts "Read #{row_count} rows and updated #{update_count} records"

  if undo_file
    puts "\nYou have a brief window to undo this by running bin/rails runner 0 #{undo_file.path} (before the temporary file gets deleted)"
    undo_file.close
  end
end

help_message unless ARGV.length == 1

change_codes(ARGV.first)

namespace :enrolments do
  task :remove_duplicates, [:commit] => [:environment] do |_task, args|
    args.with_defaults(commit: 'false')
    commit = args.commit.downcase == "true" ? true : false

    ActiveRecord::Base.transaction do
      puts "Finding users with duplicated enrolments...\n"
      index = 0
      multiple_enrolled_users = User.all.select do |u|
        print "." if (index % 100).zero?
        index = index + 1
        ids = u.user_programme_enrolments.pluck(:programme_id)
        ids.detect{ |id| ids.count(id) > 1 }
      end

      puts "\n\nCleaning up duplicated enrolments for #{multiple_enrolled_users.count} users\n\n"

      multiple_enrolled_users.each do |u|
        enrolments = u.user_programme_enrolments.order(created_at: :desc)
        puts "user: #{u.email} - removing, #{enrolments.count - 1} duplicates"
        enrolments.each_with_index do |e, index|
          if index.zero?
            puts "Keeping record: #{e.programme.title} @#{e.created_at} (#{e.current_state})"
          else
            e.destroy
          end
        end
      end

      puts "\n\nChecking results\n\n"
      multiple_enrolled_users.each do |u|
        puts "user: #{u.email}"
        u.user_programme_enrolments.order(created_at: :desc).each do |e|
          puts "#{e.programme.title} @ #{e.created_at} - #{e.current_state}"
        end
      end

      puts "\n\nDone"

      unless commit
        puts "\n\nThis was a dry-run - check results and run with 'rails enrolments:remove_duplicates[true]' to commit"
        raise ActiveRecord::Rollback
      end
    end
  end
end

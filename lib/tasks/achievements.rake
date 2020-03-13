namespace :achievements do
  desc 'Update online Achievements to rename the "commenced" state to "enrolled"'
  task migrate_to_new_state: :environment do
    achievements = Achievement.in_state('commenced')
    puts "Going to update #{achievements.count} achievements"

    ActiveRecord::Base.transaction do
      achievements.each do |achievement|
        achievement.last_transition&.update(to_state: 'enrolled')
        print '.'
      end
    end

    puts ' Done - please run an import of FL users'
  end

  task add_programme_id: :environment do
    achievements = Achievement.all
    puts "Going to update #{achievements.count} achievements, one '.' means 100"

    ActiveRecord::Base.transaction do
      achievements.each_with_index do |achievement, index|
        next unless achievement.programme_id.nil?

        achievement.send(:fill_in_programme_id)
        achievement.save

        print '.' if (index % 100).zero?
      end
    end

    puts ' Done'
  end

  task migrate_primary_diagnostic: :environment do
    primary_certificate = Programme.primary_certificate
    primary_diagnostic = Activity.find_by(slug: 'primary-certificate-diagnostic')
    questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')

    achievements = Achievement.where(activity: primary_diagnostic)

    puts "Going to migrate #{achievements.count} Primary Diagnostic achievements"

    ActiveRecord::Base.transaction do
      achievements.each_with_index do |achievement, index|
        user = achievement.user
        enrolment = user.user_programme_enrolments.find_by(programme: primary_certificate)
        next if enrolment.nil?

        response = QuestionnaireResponse.find_or_create_by(user: user, programme: primary_certificate,
                                                questionnaire: questionnaire)

        if enrolment.current_state != 'enrolled'
          response.transition_to(:complete)
        end
        print '.'
      end
      puts "\nGoing to remove old Primary Diagnostic achievements"
      achievements.destroy_all
    end

    puts 'Done'
  end
end

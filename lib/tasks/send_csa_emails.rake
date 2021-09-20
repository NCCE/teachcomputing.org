namespace :send_csa_emails do
  desc 'delivers csa emails'
  task send: :environment do
    Achievement.where(created_at: Date.today - 2.days).each do |achievement|
      if achievement.activity.provider == 'future-learn'
        #send future learn email
      end
      if achievement.activity.provider == 'stem-learning'
        #send stem learning email
      end
    end
  end

end

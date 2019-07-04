task downcase_user_emails: :environment do
  users = User.all

  users.each do |user|
    user.update(email: user.email.downcase)
  end
end

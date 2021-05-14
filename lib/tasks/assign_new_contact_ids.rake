require 'csv'
require 'open-uri'

task assign_new_contact_ids: :environment do
  contents = open('https://static.teachcomputing.org/rake/old_and_new_ids.csv')
  csv = CSV.parse(contents, headers: true)
  csv.each do |record|
    begin
      user = User.find_by!(id: record['TeachComp_UserID'].downcase)
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn "Unable to find user with TeachComp_UserID: #{record['TeachComp_UserID'].downcase}" if user.nil?
      next
    end

    begin
      user.update_attribute(:stem_achiever_contact_no, record['NEW_Crm_Contactid'].downcase)
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_later(user)
    rescue ActiveRecord::ActiveRecordError
      conflicting_account = User.find_by(stem_achiever_contact_no: record['NEW_Crm_Contactid'].downcase)
      Rails.logger.warn "Unable to save new Contact No for #{user.id}. Contact id #{record['NEW_Crm_Contactid'].downcase}: is already set for #{conflicting_account.id}"
    end
  end
end

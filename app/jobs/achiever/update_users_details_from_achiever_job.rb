class Achiever::UpdateUsersDetailsFromAchieverJob < ApplicationJob
  queue_as :achiever

  RESOURCE_PATH = "Get?cmd=ContactDetails".freeze
  CACHE = false

  def perform(user)
    query_strings = {
      Page: "1",
      RecordCount: "1000",
      CONTACTNO: user.stem_achiever_contact_no
    }

    details = Achiever::Request.resource(RESOURCE_PATH, query_strings, CACHE)[0]

    if details
      achiever_organisation_no = details.send(:"Contact.COMPANYNO")
      if achiever_organisation_no.blank?
        Rails.logger.warn "Achiever::UpdateUsersDetailsFromAchieverJob - No achiever_organisation_no for user: #{user.id}"
      else
        user.update_attribute(:stem_achiever_organisation_no, achiever_organisation_no)
      end
    else
      Rails.logger.warn "Achiever::UpdateUsersDetailsFromAchieverJob - missing user: #{user.id}"
    end
  end
end

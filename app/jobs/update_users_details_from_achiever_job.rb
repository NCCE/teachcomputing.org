class UpdateUsersDetailsFromAchieverJob < ApplicationJob
  queue_as :default

  RESOURCE_PATH = 'Get?cmd=ContactDetails'.freeze
  CACHE = false.freeze

  def perform(user)
    query_strings = {
      'Page': '1',
      'RecordCount': '1000',
      'CONTACTNO': user.stem_achiever_contact_no
    }

    details = Achiever::Request.resource(RESOURCE_PATH, query_strings, cache = CACHE)[0]

    if details
      achiever_organisation_no = details.send('Contact.COMPANYNO')
      if achiever_organisation_no.blank?
        Rails.logger.warn "UpdateUsersDetailsFromAchieverJob: No achiever_organisation_no for user: #{user.id}"
      else
        user.stem_achiever_organisation_no = achiever_organisation_no
        user.save!
      end
    else
      Rails.logger.warn "UpdateUsersDetailsFromAchieverJob: missing user: #{user.id}"
    end
  end
end

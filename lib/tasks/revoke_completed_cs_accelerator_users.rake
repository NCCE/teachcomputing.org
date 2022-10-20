# frozen_string_literal: true

require 'csv'

namespace :csa do
  desc 'revoke CSA completion so that teacher may be asked to take the test again. Accepts DRYRUN (false) & VERBOSE (true) vars.'
  task revoke: :environment do |_argv|
    # Save CSV from Google Sheet. Only include rows which need updating.
    # (N.B. The sheet referenced in https://github.com/RaspberryPiFoundation/codeclub/issues/1970
    # uses color coding to distinguish rows which need updating from ones to
    # leave untouched.)
    data_csv = 'csa_revoke.csv'
    dryrun = ActiveModel::Type::Boolean.new.cast(ENV.fetch('DRYRUN', 'false'))
    verbose = ActiveModel::Type::Boolean.new.cast(ENV.fetch('VERBOSE', 'true'))
    ActiveRecord::Base.transaction do
      CSV.foreach(data_csv, headers: true, skip_blanks: true) do |row|
        revoke_csa(user_details: row, dryrun: dryrun, verbose: verbose)
      end
    rescue ArgumentError => e
      log.warning "Failed to revoke CSA completion: #{e.inspect}"
    end
  end

  def revoke_csa(user_details:, dry_run:, verbose:)
    ['name', 'STEM ID', 'email'].each do |expected_key|
      raise ArgumentError, "CSV does not contain '#{expected_key}' column" unless user_details.key?(expected_key)

    user = User.find_by(stem_achiever_contact_no: user_details['STEM ID'].downcase)
    if user == nil
      puts "user with stem_achiever_contact_no #{user_details['STEM ID'].downcase} not found" if verbose
      return 0
    end
    
  end
end

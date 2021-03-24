class ProgrammeCompleteCounter < ApplicationRecord
  belongs_to :programme

  def get_next_number
    ActiveRecord::Base.transaction do
      next_number = counter + 1
      update!(counter: next_number)
      next_number
    end
  rescue ActiveRecord::ActiveRecordError => e
    Sentry.set_tags programme: programme
    Sentry.capture_exception(e)
  end
end

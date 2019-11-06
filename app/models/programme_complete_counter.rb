class ProgrammeCompleteCounter < ApplicationRecord
  belongs_to :programme

  def get_next_number
    begin
      ActiveRecord::Base.transaction do
        next_number = counter + 1
        update!(counter: next_number)
        next_number
      end
    rescue ActiveRecord::ActiveRecordError => error
      Raven.tags_context programme: self.programme
      Raven.capture_exception(error)
    end
  end
end

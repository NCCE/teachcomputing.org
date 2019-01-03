require 'active_support/concern'

module UserDetailable
  extend ActiveSupport::Concern

  def details
    UserDetail.find_or_create_by(stem_user_id: id)
  end
end

module Previews
  class SecondaryMailerPreview < ActionMailer::Preview
    def welcome
      SecondaryMailer.with(user: User.first).welcome
    end

    def completed
      SecondaryMailer.with(user: User.first).completed
    end

    def pending
      SecondaryMailer.with(user: User.first).pending
    end
  end
end

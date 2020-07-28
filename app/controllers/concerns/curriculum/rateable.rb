module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    NEW_FEEDBACK = 'Thank you for your feedback!'.freeze
    EXISTING_FEEDBACK = 'You have already provided a rating, thanks!'.freeze

    def rate
      raise NoMethodError unless respond_to?(:client, true)

      id = params[:id]
      polarity = params[:polarity]
      message = ''

      if helpers.user_has_rated?(id)
        message = EXISTING_FEEDBACK
      else
        response = add_rating(id, polarity)
        store_rating(id)
        message = NEW_FEEDBACK
      end

      render json: {
        origin: __method__.to_s,
        message: message,
        data: response
      }, status: :ok
    end

    def add_rating(id, polarity)
      case polarity.to_sym
      when :positive
        client.add_positive_rating(id)
      when :negative
        client.add_negative_rating(id)
      else
        raise ArgumentError, "Unexpected polarity: #{polarity}"
      end
    end

    def store_rating(id)
      raw_cookie = cookies.encrypted[:ratings]
      ratings = raw_cookie.nil? ? [] : JSON.parse(raw_cookie)
      ratings << id
      cookies.encrypted[:ratings] = { value: JSON.generate(ratings), expires: 1.month }
    end
  end
end

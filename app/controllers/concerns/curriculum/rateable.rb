module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    NEW_FEEDBACK = 'Thank you for your feedback!'.freeze
    EXISTING_FEEDBACK = 'You have already provided feedback, thanks!'.freeze

    def rate
      raise MethodMissing unless respond_to?(:client)

      id = params[:id]
      polarity = params[:polarity]
      message = EXISTING_FEEDBACK

      unless rating(id)
        response = add_rating(id, polarity)
        store_rating(id)
        message = NEW_FEEDBACK
      end

      # TODO: Would be better if this text lived in the template
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
      raw_cookie = cookies[:ratings]
      ratings = raw_cookie.nil? ? [] : JSON.parse(raw_cookie)
      ratings << id
      cookies[:ratings] = JSON.generate(ratings)
    end

    def rating(id)
      raw_cookie = cookies[:ratings]
      ratings = JSON.parse(raw_cookie) unless raw_cookie.nil?
      ratings&.include?(id)
    end
  end
end

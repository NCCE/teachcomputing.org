module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    def rate
      raise MethodMissing unless respond_to?(:client)

      id = params[:id]
      polarity = params[:polarity]

      case polarity.to_sym
      when :positive
        response = client.add_positive_rating(id)
      when :negative
        response = client.add_negative_rating(id)
      else
        raise ArgumentError, "Unexpected polarity: #{polarity}"
      end

      store_rating(id)

      # TODO: Would be better if this text lived in the template
      render json: {
        origin: __method__.to_s,
        message: 'Thank you for your feedback!',
        response: response
      }, status: :ok
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

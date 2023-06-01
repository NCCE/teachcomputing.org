module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!, only: %i[rate comment]
    end

    def rate
      raise NoMethodError unless respond_to?(:client, true)

      id = params[:id]
      polarity = params[:polarity]
      user_id = params[:user_id]

      if helpers.user_has_rated?(id)
        status = :conflict
      else
        user = current_user.present? ? current_user : User.find_by(id: user_id)
        response = add_rating(id, polarity, user)
        store_rating(id)
        rating_id = response&.id
        status = :ok
      end

      render json: {
        origin: __method__.to_s,
        rating_id:
      }, status:
    end

    def comment
      raise NoMethodError unless respond_to?(:client, true)

      response = client.update_rating(
        id: request[:rating_id],
        key: :comment,
        value: request[:comment].gsub('"', '\"')
      )

      render json: {
        origin: __method__.to_s,
        data: response
      }, status: :ok
    end

    def choices
      raise NoMethodError unless respond_to?(:client, true)

      response = client.update_rating(
        id: request[:rating_id],
        key: :choices,
        value: request[:rating_choices]
      )
      response.rating_id = request[:rating_id]
      render json: {
        origin: __method__.to_s,
        data: response
      }, status: :ok
    end

    def add_rating(id, polarity, user)
      achiever_contact_no = user.stem_achiever_contact_no

      case polarity.to_sym
      when :positive
        response = client.add_positive_rating(
          id:,
          stem_achiever_contact_no: achiever_contact_no,
          fields: 'id'
        )
      when :negative
        response = client.add_negative_rating(
          id:,
          stem_achiever_contact_no: achiever_contact_no,
          fields: 'id'
        )
      else
        raise ArgumentError, "Unexpected polarity: #{polarity}"
      end

      response
    end

    def store_rating(id)
      raw_cookie = cookies.encrypted[:ratings]
      ratings = raw_cookie.nil? ? [] : JSON.parse(raw_cookie)
      ratings << id
      cookies.encrypted[:ratings] = { value: JSON.generate(ratings), expires: 1.month, httponly: true, secure: Rails.configuration.secure_cookies }
    end
  end
end

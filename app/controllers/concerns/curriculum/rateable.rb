module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    def rate
      raise NoMethodError unless respond_to?(:client, true)

      id = params[:id]
      polarity = params[:polarity]
      user_id = params[:user_id]

      user = current_user.present? ? current_user : User.find_by(id: user_id)
      response = add_rating(id, polarity, user)
      store_rating(id)

      # TODO: Add id

      render json: {
        origin: __method__.to_s,
        data: response
      }, status: :ok
    end

    def comment
      raise NoMethodError unless respond_to?(:client, true)

      # TODO: Add comment

      render json: {
        origin: __method__.to_s,
        data: response
      }, status: :ok
    end

    def add_rating(id, polarity, user)
      achiever_contact_no = user.stem_achiever_contact_no

      case polarity.to_sym
      when :positive
        client.add_positive_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no
        )
      when :negative
        client.add_negative_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no
        )
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

module Curriculum
  module Rateable
    extend ActiveSupport::Concern

    def rate
      raise NoMethodError unless respond_to?(:client, true)

      id = params[:id]
      polarity = params[:polarity]
      user_id = params[:user_id]
<<<<<<< HEAD
      message = ''
=======
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa

      user = current_user.present? ? current_user : User.find_by(id: user_id)

      if helpers.user_has_rated?(id)
        status = :conflict
      else
<<<<<<< HEAD
=======
        user = current_user.present? ? current_user : User.find_by(id: user_id)
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
        response = add_rating(id, polarity, user)
        store_rating(id)
        rating_id = response&.id
        status = :ok
      end

      render json: {
        origin: __method__.to_s,
        rating_id: rating_id
      }, status: status
    end

    def comment
      raise NoMethodError unless respond_to?(:client, true)

      response = client.comment(
        id: request[:rating_id],
        comment: request[:comment]
      )

      render json: {
        origin: __method__.to_s,
        data: response
      }, status: :ok
    end

    def add_rating(id, polarity, user)
      achiever_contact_no = user.stem_achiever_contact_no

      case polarity.to_sym
      when :positive
<<<<<<< HEAD
        client.add_positive_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no
        )
      when :negative
        client.add_negative_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no
=======
        response = client.add_positive_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no,
          fields: 'id'
        )
      when :negative
        response = client.add_negative_rating(
          id: id,
          stem_achiever_contact_no: achiever_contact_no,
          fields: 'id'
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
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
      cookies.encrypted[:ratings] = { value: JSON.generate(ratings), expires: 1.month }
    end
  end
end

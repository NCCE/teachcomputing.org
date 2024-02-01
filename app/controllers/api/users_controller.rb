module Api
  class UsersController < ApiController
    def show
      # As we don't intigrate with Future Learn anymore, to the best of my
      # knowledge this endpoint isn't used. If it is, we will need to revisit
      # the fetching of users by email as they are no longer unique
      user = User.find_by!(email: params[:email].downcase)
      render json: as_json(user)
    end

    def forget
      user = User.find_by!(stem_user_id: params[:stem_user_id])
      user.forget!
      render json: as_json(user)
    end

    private

    def as_json(user)
      user.as_json(only: %i[id email created_at updated_at stem_achiever_contact_no stem_user_id], include: [
        {achievements: {except: %i[user_id activity_id], include: :activity,
                        methods: :current_state}},
        {enrolments: {except: %i[user_id programme_id], include: :programme,
                      methods: :current_state}}
      ])
    end
  end
end

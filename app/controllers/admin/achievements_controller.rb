module Admin
  class AchievementsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    def after_resource_destroyed_path(achievement)
      {action: :show, controller: :users, id: achievement.user.id}
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def reject_evidence
      achievement = requested_resource
      if achievement.transition_to(:rejected)
        flash_messages = ["Evidence rejected"]
        achievement.activity.programmes.each do |programme|
          enrolment = programme.user_programme_enrolments.in_state(:pending).find_by(user: achievement.user)
          if enrolment&.transition_to(:enrolled)
            flash_messages << "#{programme.title} rolled back"
          end
        end
        flash[:notice] = flash_messages.join("<br />")
      else
        flash[:alert] = "Unable to reject the evidence"
      end
      redirect_to action: :show, controller: :users, id: achievement.user.id
    end
  end
end

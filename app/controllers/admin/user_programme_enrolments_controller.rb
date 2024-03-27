module Admin
  class UserProgrammeEnrolmentsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

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

    def update
      user_programme_enrolment = UserProgrammeEnrolment.find(params[:id])

      if user_programme_enrolment.transition_to(user_programme_enrolment_params[:current_state].to_sym)
        flash[:notice] = "State changed to #{user_programme_enrolment.current_state} for #{user_programme_enrolment.programme.title}"

        redirect_to controller: :users, action: :show, id: user_programme_enrolment.user.id
      else
        flash[:alert] = "Unable to change state"

        redirect_to controller: :users, action: :edit, id: user_programme_enrolment.user.id
      end
    end

    def generate_certificate
      generator = CertificateGenerator.new(
        user: requested_resource.user,
        programme: requested_resource.programme,
        transition: requested_resource.last_transition
      )

      pdf_details = generator.generate_pdf

      send_file(
        pdf_details[:path],
        filename: pdf_details[:filename],
        type: "application/pdf",
        disposition: "inline"
      )
    end

    private

    def user_programme_enrolment_params
      params.require(:user_programme_enrolment)
        .permit(:current_state)
    end
  end
end

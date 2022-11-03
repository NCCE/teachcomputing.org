module FutureLearn
  class LtiController < ApplicationController
    before_action :authenticate_user!

    def show
      @message_authenticator = IMS::LTI::Services::MessageAuthenticator.new(
        ENV.fetch('FL_LTI_URL'),
        {
          consumer_key: ENV.fetch('FL_LTI_CONSUMER_KEY'),
          lis_person_sourcedid: current_user.id,
          lti_message_type: 'basic-lti-launch-request',
          lti_version: 'LTI-1p0',
          resource_link_id: '',
          custom_fl_course_uuid: params[:fl_id],
          custom_fl_external_learner_id: current_user.id
        },
        ENV.fetch('FL_LTI_CONSUMER_SECRET')
      )

      render :show, layout: false
    end
  end
end

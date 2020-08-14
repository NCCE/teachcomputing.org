module FutureLearn
  class LtiController < ApplicationController
    def show
      @consumer = IMS::LTI::ToolConsumer.new(
        ENV['FL_LTI_CONSUMER_KEY'],
        ENV['FL_LTI_CONSUMER_SECRET'],
        'launch_url' => ENV['FL_LTI_URL']
      )

      @consumer.custom_params = {
        fl_course_uuid: params[:fl_id],
        fl_external_learner_id: current_user.id
      }

      @consumer.lis_person_sourcedid = current_user.id
      @consumer.lti_message_type = 'basic-lti-launch-request'
      @consumer.lti_version = 'LTI-1p0'
      @consumer.resource_link_id = ''

      render :show, layout: false
    end
  end
end

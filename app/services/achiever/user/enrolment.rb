class Achiever::User::Enrolment
  RESOURCE_PATH = "Set?Cmd=CreateNCCECertificate".freeze

  def initialize(enrolment)
    @enrolment = enrolment
  end

  def last_enrolment_date
    return @enrolment.last_transition.created_at if @enrolment.state_machine.history.any?

    @enrolment.created_at
  end

  def request_body
    {
      "Entities" => [
        {"CONTACTNO" => @enrolment.user.stem_achiever_contact_no,
         "From" => last_enrolment_date.strftime("%Y-%m-%d"),
         "Type" => @enrolment.programme.slug,
         "State" => @enrolment.current_state,
         "Notes" => @enrolment.try(:last_transition).try(:metadata),
         "Title" => @enrolment.programme.title}
      ]
    }.to_json
  end

  def sync
    Achiever::Request.resource_post(RESOURCE_PATH, request_body)
  end
end

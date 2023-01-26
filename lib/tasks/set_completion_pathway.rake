task set_completion_pathway: :environment do
  cs_accelerator = Programme.cs_accelerator
  upes = UserProgrammeEnrolment.where.not(pathway_id: nil)
    .and(UserProgrammeEnrolment.where(completed_pathway_id: nil, programme_id: cs_accelerator.id))
    .in_state(:complete)

  puts "Updating #{upes.length} enrolment(s)"
  upes.each { |upe| upe.update(completed_pathway_id: upe.pathway_id) }
end

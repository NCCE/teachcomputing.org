task update_assessment_attempts_ids: :environment do
  assessment_id = Assessment.first.id
  AssessmentAttempt.update_all(assessment_id: assessment_id)
end

class CreateAsessmentAttemptTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :asessment_attempt_transitions do |t|
      t.string :to_state, null: false
      t.json :metadata, default: {}
      t.integer :sort_key, null: false
      t.integer :assessment_attempt_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :asessment_attempt_transitions, :assessment_attempts

    add_index(:asessment_attempt_transitions,
              %i[assessment_attempt_id sort_key],
              unique: true,
              name: 'index_asessment_attempt_transitions_parent_sort')
    add_index(:asessment_attempt_transitions,
              %i[assessment_attempt_id most_recent],
              unique: true,
              where: 'most_recent',
              name: 'index_asessment_attempt_transitions_parent_most_recent')
  end
end

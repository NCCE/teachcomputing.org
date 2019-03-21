class CreateAssessmentResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_responses, id: :uuid do |t|
      t.boolean :correct
      t.references :assessment, type: :uuid, null: false
      t.references :answer, type: :uuid, null: false

      t.timestamps
    end
  end
end
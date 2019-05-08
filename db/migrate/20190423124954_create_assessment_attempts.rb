class CreateAssessmentAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_attempts, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.references :assessment, type: :uuid, null: false, index: true
      t.timestamps
    end
  end
end

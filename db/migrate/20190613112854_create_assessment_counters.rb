class CreateAssessmentCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_counters, id: :uuid do |t|
      t.references :assessment, type: :uuid, null: false, index: true
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end

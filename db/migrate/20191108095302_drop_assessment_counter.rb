class DropAssessmentCounter < ActiveRecord::Migration[5.2]
  def up
    drop_table :assessment_counters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

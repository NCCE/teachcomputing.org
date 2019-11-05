class CreateProgrammeCompleteCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :programme_complete_counters, id: :uuid do |t|
      t.references :programme, type: :uuid, null: false, index: true
      t.integer :counter

      t.timestamps
    end
  end
end

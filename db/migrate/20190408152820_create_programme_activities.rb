class CreateProgrammeActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :programme_activities, id: :uuid do |t|
      t.references :programme, type: :uuid, null: false
      t.references :activity, type: :uuid, null: false

      t.timestamps
    end
  end
end

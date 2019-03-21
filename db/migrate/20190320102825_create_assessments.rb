class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :assessments, id: :uuid do |t|
      t.datetime :start_timestamp
      t.string :state
      t.references :user, type: :uuid, null: false

      t.timestamps
    end
  end
end

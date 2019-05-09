class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :assessments, id: :uuid do |t|
      t.string :link
      t.references :programme, type: :uuid, null: false
      t.references :activity, type: :uuid, null: false

      t.timestamps
    end
  end
end

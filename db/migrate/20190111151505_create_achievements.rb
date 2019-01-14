class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.references :activity, type: :uuid, null: false, index: true
      t.timestamps
    end
  end
end

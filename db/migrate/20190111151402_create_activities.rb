class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities, id: :uuid do |t|
      t.string :title
      t.float :credit
      t.timestamps
    end
  end
end

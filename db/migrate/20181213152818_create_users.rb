class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.datetime :last_sign_in_at
      t.string :user_id
      t.timestamps
      t.index ["user_id"], name: "index_users_on_user_id", unique: true
    end
  end
end

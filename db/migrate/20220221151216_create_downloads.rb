class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads, id: :uuid do |t|
      t.string :uri
      t.string :user_id

      t.timestamps
    end
  end
end

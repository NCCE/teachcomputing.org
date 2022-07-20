class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :aggregate_downloads, id: :uuid do |t|
      t.string :uri, index: true
      t.integer :count

      t.timestamps
    end

    create_table :downloads, id: :uuid do |t|
      t.belongs_to :aggregate_download, index: true, foreign_key: true, type: :uuid
      t.string :user_id, index: true

      t.timestamps
    end
  end
end

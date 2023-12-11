class CreateSearchablePages < ActiveRecord::Migration[6.1]
  def change
    create_table :searchable_pages, id: :uuid do |t|
      t.string :type
      t.string :title, null: false
      t.text :excerpt, null: false
      t.datetime :published_at

      t.jsonb :metadata, default: {}

      t.timestamps
    end
  end
end

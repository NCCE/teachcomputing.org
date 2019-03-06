class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports, id: :uuid do |t|
      t.string :provider
      t.string :triggered_by
      t.datetime :completed_at
      t.references :activity, type: :uuid, null: false, index: true
      t.timestamps
    end
  end
end

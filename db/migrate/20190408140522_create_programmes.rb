class CreateProgrammes < ActiveRecord::Migration[5.2]
  def change
    create_table :programmes, id: :uuid do |t|
      t.string :title
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end

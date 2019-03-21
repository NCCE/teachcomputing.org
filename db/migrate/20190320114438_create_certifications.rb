class CreateCertifications < ActiveRecord::Migration[5.2]
  def change
    create_table :certifications, id: :uuid do |t|
      t.string :title
      t.string :slug
      t.timestamps
    end
  end
end

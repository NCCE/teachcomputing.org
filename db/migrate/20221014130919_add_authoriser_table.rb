class AddAuthoriserTable < ActiveRecord::Migration[6.1]
  def change
    create_table :authorisers, id: :uuid do |t|
      t.string :first_name
      t.string :last_name, null: true
      t.string :organisation

      t.timestamps
    end

    add_reference :audits, :authoriser, type: :uuid, index: true
  end
end

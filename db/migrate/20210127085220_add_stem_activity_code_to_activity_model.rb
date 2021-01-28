class AddStemActivityCodeToActivityModel < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :stem_activity_code, :string, unique: true, null: true
  end
end

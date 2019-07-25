class AddTeacherReferenceNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :teacher_reference_number, :string
    add_index :users, :teacher_reference_number, unique: true
  end
end

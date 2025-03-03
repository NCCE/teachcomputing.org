class AddReplacedByActivityToActivity < ActiveRecord::Migration[7.1]
  def change
    add_reference :activities, :replaced_by, type: :uuid, null: true, foreign_key: {to_table: :activities}
  end
end

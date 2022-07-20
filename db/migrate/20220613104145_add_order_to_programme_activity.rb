class AddOrderToProgrammeActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activities, :order, :int4, null: true
  end
end

class AddActivationDateToBadge < ActiveRecord::Migration[6.1]
  def change
    add_column :badges, :activation_date, :date
  end
end

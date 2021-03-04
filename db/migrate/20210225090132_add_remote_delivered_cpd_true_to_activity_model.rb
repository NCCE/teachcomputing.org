class AddRemoteDeliveredCpdTrueToActivityModel < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :remote_delivered_cpd, :boolean, default: false
  end
end

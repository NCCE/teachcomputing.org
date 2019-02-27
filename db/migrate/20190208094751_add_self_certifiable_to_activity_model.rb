class AddSelfCertifiableToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :self_certifiable, :boolean, default: false
    add_index :activities, :self_certifiable
  end
end

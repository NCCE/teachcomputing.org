class AddSelfVerificationInfoToActivityModel < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :self_verification_info, :text, null: true
  end
end

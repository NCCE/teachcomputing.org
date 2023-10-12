class AddSelfVerificationInfoToAchievements < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :self_verification_info, :text
  end
end

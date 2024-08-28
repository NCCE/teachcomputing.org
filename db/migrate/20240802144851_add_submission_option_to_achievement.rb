class AddSubmissionOptionToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :submission_option, :string, default: nil
  end
end

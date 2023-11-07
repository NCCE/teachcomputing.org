class AddRequiredPassPercentageToAssessments < ActiveRecord::Migration[6.1]
  def change
    add_column :assessments, :required_pass_percentage, :float, null: false, default: 65.0
  end
end

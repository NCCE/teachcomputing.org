class AddCompletionInstructionToProgrammeActivityGroupings < ActiveRecord::Migration[6.1]
  def change
    add_column :programme_activity_groupings, :completion_instruction, :string
  end
end

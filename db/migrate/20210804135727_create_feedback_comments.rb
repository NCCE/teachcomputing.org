class CreateFeedbackComments < ActiveRecord::Migration[6.1]
  def change
    create_table :feedback_comments, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :area
      t.text :comment

      t.timestamps
    end
  end
end

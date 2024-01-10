class CreateUserProgrammeEnrolmentTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_programme_enrolment_transitions do |t|
      t.string :to_state, null: false
      t.json :metadata, default: {}
      t.integer :sort_key, null: false
      t.uuid :user_programme_enrolment_id, null: false
      t.boolean :most_recent, null: false

      # If you decide not to include an updated timestamp column in your transition
      # table, you'll need to configure the `updated_timestamp_column` setting in your
      # migration class.
      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :user_programme_enrolment_transitions, :user_programme_enrolments

    add_index(:user_programme_enrolment_transitions,
      %i[user_programme_enrolment_id sort_key],
      unique: true,
      name: "index_user_programme_enrolment_transitions_parent_sort")
    add_index(:user_programme_enrolment_transitions,
      %i[user_programme_enrolment_id most_recent],
      unique: true,
      where: "most_recent",
      name: "index_user_programme_enrolment_transitions_parent_most_recent")
  end
end

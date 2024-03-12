# previously we only had one verification info textbox, which was mapped to a
# single database column. now we have multiple steps or questions, each with
# their own evidence field. this migration creates a json column to store that
# new

class AchievementsAddEvidence < ActiveRecord::Migration[6.1]
  def up
    add_column :achievements, :evidence, :jsonb, null: false, default: []

    # migrate all existing evidence to the new column
    Achievement
      .with_attached_supporting_evidence
      .includes(:activity, :achievement_transitions, :user)
      .find_in_batches(batch_size: 1000) do |group|
      # the last evidence that the user submitted or saved for this achievement
      # could exist on either the most recent state transition or the achievement
      # record itself.
      #
      # we look on the record first, and if we can't find it there we check on the
      # state transition.
      group
        .each do |achievement|
          existing_evidence = achievement.self_verification_info.presence || achievement.state_machine.last_transition&.metadata&.dig("self_verification_info")
          next if existing_evidence.blank?

          achievement.self_verification_steps = [existing_evidence]
          achievement.save!
        end
    end
  end

  def down
    remove_column :achievements, :evidence
  end
end

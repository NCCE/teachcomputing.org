class AddProgrammeAndOrderToPathways < ActiveRecord::Migration[6.1]
  def up
    add_column :pathways, :programme_id, :uuid, null: true

    query = <<~SQL
      UPDATE
        pathways
      SET
        programme_id = (
          SELECT
            id
          FROM
            programmes
          WHERE
            slug = 'cs-accelerator');
    SQL
    execute query

    change_column :pathways, :programme_id, :uuid, null: false
    add_index :pathways, :programme_id

    add_column :pathways, :order, :int4
  end

  def down
    remove_column :pathways, :programme_id
    remove_column :pathways, :order
  end
end

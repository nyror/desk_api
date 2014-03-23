class CreateCaseLabelRelations < ActiveRecord::Migration
  def change
    create_table :case_label_relations do |t|
      t.integer :desk_case_id
      t.integer :desk_label_id

      t.timestamps
    end
  end
end

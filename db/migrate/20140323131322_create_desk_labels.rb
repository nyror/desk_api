class CreateDeskLabels < ActiveRecord::Migration
  def change
    create_table :desk_labels do |t|
      t.string :name

      t.timestamps
    end
  end
end

class AddColorToDeskLabel < ActiveRecord::Migration
  def change
    add_column :desk_labels, :color, :string
  end
end

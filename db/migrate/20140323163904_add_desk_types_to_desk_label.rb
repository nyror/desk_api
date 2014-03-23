class AddDeskTypesToDeskLabel < ActiveRecord::Migration
  def change
    add_column :desk_labels, :desk_types, :string
  end
end

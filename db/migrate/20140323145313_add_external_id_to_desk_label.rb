class AddExternalIdToDeskLabel < ActiveRecord::Migration
  def change
    add_column :desk_labels, :external_id, :string
  end
end

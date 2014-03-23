class AddEnabledToDeskLabel < ActiveRecord::Migration
  def change
    add_column :desk_labels, :enabled, :string
  end
end

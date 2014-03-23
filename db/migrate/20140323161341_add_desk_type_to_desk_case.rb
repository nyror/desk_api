class AddDeskTypeToDeskCase < ActiveRecord::Migration
  def change
    add_column :desk_cases, :desk_type, :string
  end
end

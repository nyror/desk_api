class AddExternalIdToDeskCase < ActiveRecord::Migration
  def change
    add_column :desk_cases, :external_id, :string
  end
end

class CreateDeskCases < ActiveRecord::Migration
  def change
    create_table :desk_cases do |t|
      t.string :headline
      t.string :status

      t.timestamps
    end
  end
end

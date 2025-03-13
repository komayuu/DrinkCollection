class ChangeCategoryToIntegerInDrinks < ActiveRecord::Migration[7.1]
  def up
    change_column :drinks, :category, :integer, using: "category::integer"
  end

  def down
    change_column :drinks, :category, :string
  end
end

class AddCategoryToDrinks < ActiveRecord::Migration[7.1]
  def change
    add_column :drinks, :category, :string
  end
end

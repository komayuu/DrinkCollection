class AddCategoryIdToDrinks < ActiveRecord::Migration[7.1]
  def change
    add_column :drinks, :category_id, :integer
  end
end

class RemoveCategoryFromDrinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :drinks, :category, :integer
  end
end

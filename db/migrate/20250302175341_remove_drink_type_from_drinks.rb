class RemoveDrinkTypeFromDrinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :drinks, :drink_type, :string
  end
end

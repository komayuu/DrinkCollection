class AddIsAdminToDrinks < ActiveRecord::Migration[7.1]
  def change
    add_column :drinks, :is_admin, :boolean
  end
end

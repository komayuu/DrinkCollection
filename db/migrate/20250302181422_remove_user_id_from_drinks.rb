class RemoveUserIdFromDrinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :drinks, :user_id, :bigint
  end
end

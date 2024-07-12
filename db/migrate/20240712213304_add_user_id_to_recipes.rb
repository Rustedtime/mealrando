class AddUserIdToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :user
  end
end

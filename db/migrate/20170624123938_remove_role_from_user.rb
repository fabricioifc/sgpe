class RemoveRoleFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role
  end
end

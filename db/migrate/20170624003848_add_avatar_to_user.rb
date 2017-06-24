class AddAvatarToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar, :string
  end

  def self.down
    remove_column :users, :avatar
  end
end

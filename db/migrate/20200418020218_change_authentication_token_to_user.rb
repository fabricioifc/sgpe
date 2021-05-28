class ChangeAuthenticationTokenToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :authentication_token, :string, limit: 100
  end
end

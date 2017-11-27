class AddParecerToPlano < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :parecer, :text
  end
end

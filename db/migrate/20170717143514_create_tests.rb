class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.string :title
      t.string :body
      t.boolean :active

      t.timestamps
    end
  end
end

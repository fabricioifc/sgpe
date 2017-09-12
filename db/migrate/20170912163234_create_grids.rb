class CreateGrids < ActiveRecord::Migration[5.1]
  def change
    create_table :grids do |t|
      t.integer :year, null:false
      t.boolean :active, default:true
      t.references :course, foreign_key: true, index:true, null:false
      t.references :user, foreign_key: true, index:true

      t.timestamps
    end
  end
end

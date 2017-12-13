class ChangeColumnSiglaFromCourse < ActiveRecord::Migration[5.1]
  def change
    change_column :courses, :sigla, :string, limit: 10, null:false
  end
end

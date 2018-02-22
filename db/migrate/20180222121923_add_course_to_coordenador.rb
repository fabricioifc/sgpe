class AddCourseToCoordenador < ActiveRecord::Migration[5.1]
  def change
    add_reference :coordenadors, :course, foreign_key: true, index:true, null:false
  end
end

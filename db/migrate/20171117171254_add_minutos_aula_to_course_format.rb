class AddMinutosAulaToCourseFormat < ActiveRecord::Migration[5.1]
  def change
    add_column :course_formats, :minutos_aula, :integer
  end
end

class RemoveCargaHorariaFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :carga_horaria
  end
end

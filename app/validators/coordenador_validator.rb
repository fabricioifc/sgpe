class CoordenadorValidator < ActiveModel::Validator

    # Verificar se a data de inicio for maior ou igual a data inicial 
    # de algum coordenador vinculado ao mesmo curso
    # def validate(record)
    #     if !record.course_id.nil? && !record.dtinicio.nil? && !record.dtfim.nil?
    #         dtinicio_clause = Coordenador.arel_table[:dtinicio]
    #         dtfim_clause = Coordenador.arel_table[:dtfim]
            
    #         coordenadores = Coordenador.where(course_id: record.course_id).
    #             where.not(id: record.id).
    #             where(dtinicio_clause.lteq(record.dtinicio))

    #         if !coordenadores.empty?
    #             record.errors.add(:dtinicio, "Já existe um coordenador cadastrado para este curso entre estas datas.")
    #         end
            
    #     end
    # end
end
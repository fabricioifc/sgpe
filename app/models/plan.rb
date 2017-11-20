class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :user

  validates :offer_discipline_id, :obj_espe, :conteudo_prog, :prat_prof, :interdisc, :met_tec, :met_met, :avaliacao, :cronograma, :atendimento, presence:true,
    if: Proc.new { |a| a.analise? }

  def decorate
    @decorate ||= PlanDecorator.new self
  end

end

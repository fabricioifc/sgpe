class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :user, :class_name => 'User'
  belongs_to :user_parecer, :class_name => 'User', optional:true

  validates :offer_discipline_id, presence:true,
    if: Proc.new { |a| a.analise? }

  validates :obj_espe, :conteudo_prog, :prat_prof, :interdisc, :met_tec, :met_met, :avaliacao, :cronograma, :atendimento,
    html: { presence: true },
    if: Proc.new { |a| a.analise? }

  def decorate
    @decorate ||= PlanDecorator.new self
  end

end

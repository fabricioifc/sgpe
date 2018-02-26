class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :user, :class_name => 'User'
  belongs_to :user_parecer, :class_name => 'User', optional:true
  belongs_to :coordenador

  # attr_accessor :ementa, :objetivo_geral, :bib_geral, :bib_espec

  validates :offer_discipline_id, presence:true,
    if: Proc.new { |a| a.analise? }

  validates :obj_espe, :conteudo_prog, :prat_prof, :interdisc, :met_tec, :met_met, :avaliacao, :cronograma, :atendimento,
    html: { presence: true },
    if: Proc.new { |a| a.analise? }

  validates :ead_percentual_definido, presence:true, if: Proc.new { |a| a.analise? &&
    !a.offer_discipline.ead_percentual_maximo.nil? && !a.offer_discipline.ead_percentual_maximo.eql?(0)
  }

  # validates :ementa, presence:true, if: Proc.new { |a| a.analise? && a.offer_discipline.grid_discipline.discipline.especial? }
  # validates :objetivo_geral, presence:true, if: Proc.new { |a| a.analise? && a.offer_discipline.grid_discipline.discipline.especial? }
  # validates :bib_geral, presence:true, if: Proc.new { |a| a.analise? && a.offer_discipline.grid_discipline.discipline.especial? }
  # validates :bib_espec, presence:true, if: Proc.new { |a| a.analise? && a.offer_discipline.grid_discipline.discipline.especial? }

  accepts_nested_attributes_for :offer_discipline

  def decorate
    @decorate ||= PlanDecorator.new self
  end

end

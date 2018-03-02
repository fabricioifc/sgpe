class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :user, :class_name => 'User'
  belongs_to :user_parecer, :class_name => 'User', optional:true
  belongs_to :coordenador, optional:true

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

  def self.em_analise
    where(analise: true, aprovado:false, reprovado:false)
  end

  def self.aprovados
    where(analise: true, aprovado:true, reprovado:false)
  end

  def self.reprovados
    where(analise: true, aprovado:false, reprovado:true)
  end

  # joins(:offer_discipline => { :offer => { :grid => :course}}).
  def self.search_coordenador(ano_oferta, semestre_oferta, curso_id)
    joins('RIGHT OUTER JOIN "offer_disciplines" ON "offer_disciplines"."id" = "plans"."offer_discipline_id"').
      joins('RIGHT OUTER JOIN "grid_disciplines" ON "grid_disciplines"."id" = "offer_disciplines"."grid_discipline_id"').
      joins('RIGHT OUTER JOIN "disciplines" ON "disciplines"."id" = "grid_disciplines"."discipline_id"').
      joins('RIGHT OUTER JOIN "offers" ON "offers"."id" = "offer_disciplines"."offer_id"').
      joins('RIGHT OUTER JOIN "grids" ON "grids"."id" = "grid_disciplines"."grid_id"').
      joins('RIGHT OUTER JOIN "courses" ON "courses"."id" = "grids"."course_id"').
      where('courses.id = ?', curso_id)
  end
  # where(:offer_disciplines => { :offers => { :grids => { :course_id => curso_id }}})


  # def self.search_coordenador(analise, aprovado, reprovado, ano_oferta)
  #   joins(:offer_discipline => :offer).
  #     where(:offers => { :year => ano_oferta })
  #     where(analise && aprovado && reprovado ? 'analise is true OR aprovado is true OR reprovado is true' : '').
  #     where(!analise && !aprovado && !reprovado ? 'analise is true OR aprovado is true OR reprovado is true' : '').
  #     where(analise && !aprovado && !reprovado ? 'analise is true AND aprovado is false and reprovado is false' : '').
  #     where(analise && aprovado && !reprovado ? '(analise is true OR aprovado is true) and reprovado is false' : '').
  #     where(analise && !aprovado && reprovado ? '(analise is true OR reprovado is true) and aprovado is false' : '').
  #     where(!analise && aprovado && !reprovado ? 'analise is false AND (aprovado is true AND reprovado is false)' : '').
  #     where(!analise && !aprovado && reprovado ? 'analise is false AND (aprovado is false AND reprovado is true)' : '')
  # end

  # scope :search_coordenador, ->(analise, aprovado, reprovado, ano_oferta) {
  #   contition = joins(:offer_discipline => :offer).
  #     where(:offers => { :year => ano_oferta })
  #   condition = Plan.em_analise if analise?
  # }

end

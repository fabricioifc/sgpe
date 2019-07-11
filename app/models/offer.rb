class Offer < ApplicationRecord
  belongs_to :grid
  belongs_to :course_format
  # belongs_to :turma
  has_many :offer_disciplines, dependent: :destroy
  accepts_nested_attributes_for :offer_disciplines

  enum offer_types: {
    regular: 'Regular', domiciliar: 'Exercício domiciliar', distancia: 'Atividades Não Presenciais',
    reoferta: 'Reoferta', dependencia: 'Dependência'
  }

  validates :type_offer, :grid_id, :minutos_aula, presence:true
  validates :semestre, presence: { if: -> { self.grid.course.course_offer.description.eql?("semestral") } }
  validates :minutos_aula, :numericality => { :greater_than => 0 }

  validates :year, presence: { if: -> { semestre.blank? } },
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  validates :offer_disciplines, presence:true#, on: [:update]
  
  validates :grid_id,
    uniqueness: {
      scope: [:turma, :year, :semestre, :grid_id, :type_offer],
      conditions: -> { where(active: true) },
      message: lambda { |x, y| "Já existe grade ofertada para esta turma, ano e semestre." }
    }
  
    # validates :turma, :dtprevisao_entrega_plano, presence:false
  validates :dtprevisao_entrega_plano, date: { if: -> { !dtprevisao_entrega_plano.blank? } }

  # accepts_nested_attributes_for :grid_disciplines, :allow_destroy => true

  def decorate
    @decorate ||= OfferDecorator.new self
  end

  attr_accessor :grid_year, :grid_semestre

  def attributes
    super.merge(
      'grid_year' => self.grid_year,
      'grid_semestre' => self.grid_semestre,
      'offer_disciplines' => self.offer_disciplines.build
    )
  end
end

class Coordenador < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :plans

  validates :user_id, :course_id, :funcao, :email, presence:true
  validates :course_id, :user_id,
    uniqueness: {scope: [:course_id, :user_id]}

    # validate :verificar_titular
  # validate :verificar_responsavel
  validates_with CoordenadorValidator

  validates :dtinicio, presence:true, date: { before_or_equal_to: :dtfim }
  validates :dtfim, presence:true, date: { after_or_equal_to: :dtinicio }

  # validates :course_id, :dtinicio, :titular,
  #   uniqueness: {
  #     scope: [:course_id, :dtinicio, :titular],
  #     conditions: -> { where(course_id: :course_id).where.not() },
  #     # Post.where(arel[:created_].gt 1.day.ago).to_sql
  #
  #     message: lambda { |x, y| "Já existe um coordenador cadastrado para este mesmo curso nestas datas." }
  #   }

  def decorate
    @decorate ||= CoordenadorDecorator.new self
  end

  # Buscar os coordenadores por curso e com data atual entre datas de inicio e fim
  scope :por_curso, -> (course_id, data_plano) {
    where(responsavel:true, course_id: course_id).
      where(
        Coordenador.arel_table[:dtinicio].lteq(data_plano).
        and(Coordenador.arel_table[:dtfim].gteq(data_plano))
      )
  }

  scope :is_coordenador, -> (loggedin_user) {
    where(user: loggedin_user).
      where(
        Coordenador.arel_table[:dtinicio].lteq(Date.today).
        and(Coordenador.arel_table[:dtfim].gteq(Date.today))
      )
  }

  private

  # def verificar_titular
  #   titulares = Coordenador.where(course_id: self.course_id, titular:true).where.not(id: self.id).count
  #   if titulares == 0 && !self.titular?
  #     errors.add(:titular, "Marque como coordenador titular para este curso.")
  #   # elsif titulares > 0 && self.titular?
  #   #   errors.add(:titular, "Já existe um coordenador titular para este curso.")
  #   end
  # end

  def verificar_responsavel
    responsaveis = Coordenador.where(course_id: self.course_id, responsavel:true).where.not(id: self.id).count
    if responsaveis == 0 && !self.responsavel?
      errors.add(:responsavel, "Nenhum coordenador marcado como responsável para este curso.")
    # elsif responsaveis > 0 && self.responsavel?
      # errors.add(:responsável, "Já existe um coordenador responsavel por este curso.")
    end
  end

end

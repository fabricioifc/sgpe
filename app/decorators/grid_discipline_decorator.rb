class GridDisciplineDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def ano_semestre
    if !component.year.nil? && !component.semestre.nil?
      "#{component.year}/#{component.semestre}"
    elsif !component.year.nil? && component.semestre.nil?
      "Ano: #{component.year}"
    else
      "Semestre: #{component.semestre}"
    end
  end

  def active
    active_tag component.active?, 'fa-2'
  end

  def ementa pdf = false
    formatar_texto component.ementa, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.ementa.html_safe) unless component.ementa.nil?
  end

  def objetivo_geral pdf = false
    formatar_texto component.objetivo_geral, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.objetivo_geral.html_safe) unless component.objetivo_geral.nil?
  end

  def bib_geral pdf = false
    formatar_texto component.bib_geral, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.bib_geral.html_safe) unless component.bib_geral.nil?
  end

  def bib_espec pdf = false
    formatar_texto component.bib_espec, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.bib_espec.html_safe) unless component.bib_espec.nil?
  end

  def year
    component.year.to_s << '°' unless component.year.nil?
  end

  def semestre
    component.semestre.to_s << '°' unless component.semestre.nil?
  end

  def carga_horaria_hora_text
    component.carga_horaria.to_s << ' H'
  end

  def carga_horaria_aula
    carga_horaria_aula_generic(component.grid.course.course_format.minutos_aula, component.carga_horaria)
  end

  def carga_horaria_aula_text
    carga_horaria_aula.to_s << ' H/A'
  end

end

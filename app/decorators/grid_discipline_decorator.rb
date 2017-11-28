class GridDisciplineDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def active
    active_tag component.active?, 'fa-2'
  end

  def ementa pdf = false
    converter_para_html component.ementa, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.ementa.html_safe) unless component.ementa.nil?
  end

  def objetivo_geral pdf = false
    converter_para_html component.objetivo_geral, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.objetivo_geral.html_safe) unless component.objetivo_geral.nil?
  end

  def bib_geral pdf = false
    converter_para_html component.bib_geral, pdf
    # ActionView::Base.full_sanitizer.sanitize(component.bib_geral.html_safe) unless component.bib_geral.nil?
  end

  def bib_espec pdf = false
    converter_para_html component.bib_espec, pdf
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
    minutos_aula = component.grid.course.course_format.minutos_aula
    (component.carga_horaria / (minutos_aula.to_f / 60)).to_i  unless component.carga_horaria.nil? || minutos_aula.nil?
  end

  def carga_horaria_aula_text
    carga_horaria_aula.to_s << ' H/A'
  end

end

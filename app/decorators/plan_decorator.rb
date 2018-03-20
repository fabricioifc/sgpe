class PlanDecorator < ApplicationDecorator
  include PlansHelper
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def carga_horaria_presencial_distancia
    horarios = { presencial: 0, distancia: 0 }

    if !component.offer_discipline.grid_discipline.carga_horaria.nil?
      carga_horaria = component.offer_discipline.carga_horaria || component.offer_discipline.grid_discipline.carga_horaria
      horarios[:presencial] = carga_horaria

      if !component.ead_percentual_definido.nil? && !component.ead_percentual_definido.eql?(0)
        horarios[:distancia] = ((carga_horaria * component.ead_percentual_definido).to_f / 100).round(2)
        horarios[:presencial] = (carga_horaria - horarios[:distancia]).round(2)
      end

      minutos_aula = component.offer_discipline.grid_discipline.grid.course.course_format.minutos_aula

      # carga horária aula total
      caraga_horaria_aula_total = carga_horaria_aula_generic(minutos_aula, carga_horaria)
      # carga horaria aula presencial
      distancia_aula = carga_horaria_aula_generic(minutos_aula, horarios[:distancia])

      horarios[:distancia_aula] = distancia_aula.to_s << ' H/A'
      horarios[:presencial_aula] = (caraga_horaria_aula_total - distancia_aula).to_s << ' H/A'
      # horarios[:distancia_aula] = carga_horaria_aula_generic(minutos_aula, horarios[:distancia]).to_s << ' H/A'
      horarios[:presencial] = horarios[:presencial].to_s << ' H'
      horarios[:distancia] = horarios[:distancia].to_s << ' H'
    end
    horarios
  end

  def obj_espe pdf = false
    formatar_texto component.obj_espe, pdf
  end

  def conteudo_prog pdf = false
    formatar_texto component.conteudo_prog, pdf
  end

  def prat_prof pdf = false
    formatar_texto component.prat_prof, pdf
  end

  def interdisc pdf = false
    formatar_texto component.interdisc, pdf
  end

  def met_tec pdf = false
    formatar_texto component.met_tec, pdf
  end

  def met_met pdf = false
    formatar_texto component.met_met, pdf
  end

  def avaliacao pdf = false
    formatar_texto component.avaliacao, pdf
  end

  def cronograma pdf = false
    formatar_texto component.cronograma, pdf
  end

  def atendimento pdf = false
    formatar_texto component.atendimento, pdf
  end

  def observacoes pdf = false
    formatar_texto component.observacoes, pdf
  end

  def versao
    component.versao.to_f unless component.versao.nil?
  end

  def situacao classes = ''
    # active_tag component.active?, 'fa-2'
    if component.aprovado?
      h.content_tag :span, 'Aprovado', class: "label #{classes} label-success", style: 'font-size: 14px;'
    elsif component.reprovado?
      h.content_tag :span, 'Pendências', class: "label #{classes} label-danger", style: 'font-size: 14px;'
    elsif component.analise?
      h.content_tag :span, 'Em análise', class: "label #{classes} label-warning", style: 'font-size: 14px;'
    else
      h.content_tag :span, 'Editando', class: "label #{classes} label-primary", style: 'font-size: 14px;'
    end
  end

  def situacao_texto
    if component.aprovado?
      'Aprovado'
    elsif component.reprovado?
      'Pendências'
    elsif component.analise?
      'Em análise'
    else
      'Editando'
    end
  end

  def link_pdf classes = 'btn-sm'
    if !component.id.nil?
      h.link_to h.offer_offer_discipline_plan_path(id: component.id,
                                                 offer_discipline_id: component.offer_discipline_id,
                                                 offer_id: component.offer_discipline.offer_id,
                                                 format: :pdf),
      class: "btn btn-primary #{classes}", target:'' do
        h.content_tag :i, nil, class: 'fa fa-file-pdf-o' do
          h.content_tag :span, " #{I18n.t 'helpers.links.pdf'}"
        end
      end
    end
  end

  def link_editar classes = 'btn-sm'
    if !component.id.nil?
      if pode_editar?
        h.link_to h.edit_offer_offer_discipline_plan_path(offer_discipline_id: component.offer_discipline_id, id: component.id),
          class: "btn btn-warning #{classes}" do
            h.content_tag :i, nil, class: 'fa fa-edit' do
              h.content_tag :span, " #{I18n.t 'helpers.links.edit'}"
            end
        end
      else
        h.button_tag nil, class: "btn btn-warning #{classes}", disabled:true do
            h.content_tag :i, nil, class: 'fa fa-edit' do
              h.content_tag :span, " #{I18n.t 'helpers.links.edit'}"
            end
        end
      end
    end
  end

  def link_show classes = 'btn-sm'
    h.link_to h.offer_offer_discipline_plan_path(id: component.id,
                                               offer_discipline_id: component.offer_discipline_id,
                                               offer_id: component.offer_discipline.offer_id),
      class: "btn btn-info #{classes}" do
        h.content_tag :i, nil, class: 'fa fa-info-circle' do
          h.content_tag :span, " #{I18n.t 'helpers.links.show'}"
        end
    end
  end

  def link_index classes = 'btn-sm'
    h.link_to h.offer_offer_discipline_plans_path(offer_discipline_id: component.offer_discipline_id),
      class: "btn btn-default #{classes}" do
        h.content_tag :i, nil, class: 'fa fa-list' do
          h.content_tag :span, " #{I18n.t 'helpers.links.back'}"
        end
    end
  end

  def link_new classes = 'btn-sm'
    if pode_novo?
      h.link_to h.new_offer_offer_discipline_plan_path(offer_discipline_id: component.offer_discipline_id),
        class: "btn btn-primary #{classes}" do
          h.content_tag :i, nil, class: 'fa fa-plus' do
            h.content_tag :span, " #{I18n.t 'helpers.links.new'}"
          end
      end
    else
      h.button_tag nil, class: "btn btn-primary #{classes}", disabled:true do
          h.content_tag :i, nil, class: 'fa fa-plus' do
            h.content_tag :span, " #{I18n.t 'helpers.links.new'}"
          end
      end
    end
  end

  def link_duplicate classes = 'btn-sm'
    if pode_excluir?
      h.link_to h.offer_offer_discipline_plan_path(id: component.id),
        method: :delete, data: { confirm: 'Tem certeza?' },
        class: "btn btn-danger #{classes}" do
        h.content_tag :i, nil, class: 'fa fa-trash-o' do
          h.content_tag :span, " #{I18n.t('helpers.links.destroy', model: component.model_name.human)}"
        end
      end
    elsif pode_novo?
      h.link_to h.copy_offer_offer_discipline_plan_path(offer_discipline_id: component.offer_discipline_id, id: component.id),
        class: "btn btn-primary #{classes}" do
        h.content_tag :i, nil, class: 'fa fa-plus' do
          h.content_tag :span, " #{I18n.t('helpers.links.duplicate', model: component.model_name.human)}"
        end
      end
    else
      h.button_tag nil, class: "btn btn-primary #{classes}", disabled:true do
        h.content_tag :i, nil, class: 'fa fa-plus' do
          h.content_tag :span, " #{I18n.t('helpers.links.duplicate', model: component.model_name.human)}"
        end
      end
    end
  end

  def pode_novo?
    # component.aprovado? || component.reprovado?
    !plano_sendo_editado?(component.offer_discipline_id) && nenhum_plano_em_analise?(component.offer_discipline_id)
  end

  def pode_editar?
     nenhum_plano_em_analise?(component.offer_discipline_id) && !component.aprovado? && !component.reprovado?
  end

  def pode_excluir?
    !component.analise? && !component.aprovado? && !component.reprovado?
  end

  # def pode_gerar_pdf?
  #   component.aprovado?
  # end

private

  # def verificar_status_planos?
  #   Plan.where(offer_discipline_id: component.offer_discipline_id, active:true).
  #     where(analise:true).where(aprovado:false, reprovado:false).empty?
  # end

  def plano_aprovado
    Plan.where(offer_discipline_id: component.offer_discipline_id, active:true).
      where(analise:true).where(aprovado:true, reprovado:false).order(versao: :desc).first
  end

end

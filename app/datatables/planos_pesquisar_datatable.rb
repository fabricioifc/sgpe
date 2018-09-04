class PlanosPesquisarDatatable < ApplicationDatatable
  delegate :offer_offer_discipline_plan_path, to: :@view

  def initialize(view)
    @view = view
    super
  end

private

  def data
    planos.map do |plano|
      [].tap do |column|

        column << "#{plano.offer_discipline.grid_discipline.grid.course.sigla} - #{plano.offer_discipline.grid_discipline.grid.course.name}"
        column << plano.offer_discipline.offer.decorate.ano_semestre
        # column << plano.offer_discipline.offer.turma
        column << "#{plano.offer_discipline.grid_discipline.discipline.sigla} - #{plano.offer_discipline.grid_discipline.discipline.title}"

        # links = []
        column << link_to("<i class='fa fa-info-circle'></i> <span>#{I18n.t 'helpers.links.show'}</span>".html_safe,
            offer_offer_discipline_plan_path(
                offer_discipline_id: plano.offer_discipline_id,
                offer_id: plano.offer_discipline.offer_id,
                id: plano.id), class: "btn btn-xs btn-info btn-block")
       column << plano.decorate.link_pdf('btn-xs btn-block')

        # column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_plano_path(plano))
        # column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, plano, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end unless planos.nil?
  end

  # Returns the count of records.
  def count
    if planos.nil?
      0
    else
      planos.count
    end
  end

  def total_entries
    if planos.nil?
      0
    else
      planos.total_count
    end
    # will_paginate
    # planos.total_entries
  end

  def planos
    @planos ||= fetch_planos
  end

  def fetch_planos
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    offer_discipline_ids = Plan.select('plans.offer_discipline_id, MAX(plans.id) AS idplano').
      where.not(user:nil).
      where(aprovado:true, active:true).group(:offer_discipline_id)

    # planos = []
    # offer_discipline_ids.map { |od|
    #   planos << Plan.where(offer_discipline_id: od.offer_discipline_id, versao: od.versao)
    # }
    planos = Plan.joins(:offer_discipline => {:grid_discipline => {:grid => :course}}).
      joins(:offer_discipline => {:grid_discipline => :discipline}).
      joins(:offer_discipline => :offer).
      where(id: offer_discipline_ids.map(&:idplano)).order("#{sort_column} #{sort_direction}")

      planos = planos.page(page).per(per_page)
      planos = planos.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end
  # where('plans.user_parecer_id is null OR plans.user_parecer_id != ?', @user.id).

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(grids.year courses.name courses.sigla disciplines.sigla disciplines.title offers.year offers.turma)
  end
end

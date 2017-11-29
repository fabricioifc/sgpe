class AprovarPlanosDatatable < ApplicationDatatable
  delegate :offer_offer_discipline_plan_path, to: :@view

  def initialize(view)
    @view = view
  end

private

  def data
    # binding.pry
    planos.map do |plano|
      [].tap do |column|

        column << "#{plano.offer_discipline.grid_discipline.grid.year} - #{plano.offer_discipline.grid_discipline.grid.course.name}"
        column << "#{plano.offer_discipline.grid_discipline.discipline.sigla} - #{plano.offer_discipline.grid_discipline.discipline.title}"
        column << "#{plano.offer_discipline.offer.turma.year} - #{plano.offer_discipline.offer.turma.name}"
        column << plano.user.name
        column << plano.offer_discipline.offer.decorate.ano_semestre
        column << plano.decorate.situacao

        # links = []
        column << link_to("<i class='fa fa-info-circle'></i> <span>#{I18n.t 'helpers.links.show'}</span>".html_safe,
            offer_offer_discipline_plan_path(
                offer_discipline_id: plano.offer_discipline_id,
                offer_id: plano.offer_discipline.offer_id,
                id: plano.id), class: "btn btn-xs btn-info btn-block")

        # column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_plano_path(plano))
        # column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, plano, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Plan.count
  end

  def total_entries
    planos.total_count
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

    # will_paginate
    # planos = plano.page(page).per_page(per_page)
    planos = Plan.joins(offer_discipline: {offer: { grid: :course }}).
      joins(offer_discipline: {grid_discipline: :discipline }).
      joins(:user).
      where('plans.active is true').
      where('analise is true OR aprovado is true OR reprovado is true').
      order(analise: :desc, reprovado: :asc, aprovado: :asc).
      order("#{sort_column} #{sort_direction}")
    planos = planos.page(page).per(per_page)
    planos = planos.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(grids.year courses.name users.name disciplines.sigla disciplines.title offers.year)
  end
end

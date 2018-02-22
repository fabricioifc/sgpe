class CoordenadorDatatable < ApplicationDatatable
  delegate :edit_coordenador_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    coordenadors.map do |coordenador|
      [].tap do |column|

        column << coordenador.name
        column << coordenador.course.name
        column << coordenador.siape
        column << coordenador.dtinicio
        column << coordenador.dtfim
        column << coordenador.decorate.titular
        column << coordenador.decorate.responsavel

        # links = []
        column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, coordenador)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_coordenador_path(coordenador))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, coordenador, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Coordenador.count
  end

  def total_entries
    coordenadors.total_count
    # will_paginate
    # coordenadors.total_entries
  end

  def coordenadors
    @coordenadors ||= fetch_coordenadors
  end

  def fetch_coordenadors
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # coordenadors = Coordenador.page(page).per_page(per_page)
    coordenadors = Coordenador.joins(:course).order("#{sort_column} #{sort_direction}")
    coordenadors = coordenadors.page(page).per(per_page)
    coordenadors = coordenadors.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(coordenadors.name funcao siape titular email dtinicio dtfim responsavel courses.name)
  end
end

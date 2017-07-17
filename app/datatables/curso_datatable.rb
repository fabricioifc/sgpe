class CursoDatatable < ApplicationDatatable
  delegate :edit_curso_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    cursos.map do |curso|
      [].tap do |column|

        column << curso.id
        column << curso.title
        column << curso.sigla
        column << curso.description
        column << curso.decorate.active

        links = []
        links << link_to("<i class='fa fa-list fa-2'></i>".html_safe, curso)
        links << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_curso_path(curso))
        links << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, curso, method: :delete, data: { confirm: 'Tem certeza?' })
        column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Curso.count
  end

  def total_entries
    cursos.total_count
    # will_paginate
    # cursos.total_entries
  end

  def cursos
    @cursos ||= fetch_cursos
  end

  def fetch_cursos
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # cursos = Curso.page(page).per_page(per_page)
    cursos = Curso.order("#{sort_column} #{sort_direction}")
    cursos = cursos.page(page).per(per_page)
    cursos = cursos.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id title sigla description idativo)
  end
end

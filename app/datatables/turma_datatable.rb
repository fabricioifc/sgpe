class TurmaDatatable < ApplicationDatatable
  delegate :edit_turma_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    turmas.map do |turma|
      [].tap do |column|

        column << turma.name
        column << turma.year
        column << turma.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, turma)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_turma_path(turma))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, turma, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Turma.count
  end

  def total_entries
    turmas.total_count
    # will_paginate
    # turmas.total_entries
  end

  def turmas
    @turmas ||= fetch_turmas
  end

  def fetch_turmas
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # turmas = Turma.page(page).per_page(per_page)
    turmas = Turma.order("#{sort_column} #{sort_direction}")
    turmas = turmas.page(page).per(per_page)
    turmas = turmas.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id name year active)
  end
end

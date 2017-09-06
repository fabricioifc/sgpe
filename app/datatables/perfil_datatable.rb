class PerfilDatatable < ApplicationDatatable
  delegate :edit_perfil_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    perfils.map do |perfil|
      [].tap do |column|

        column << perfil.id
        column << perfil.name
        column << perfil.decorate.idativo

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, perfil)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_perfil_path(perfil))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, perfil, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Perfil.count
  end

  def total_entries
    perfils.total_count
    # will_paginate
    # perfils.total_entries
  end

  def perfils
    @perfils ||= fetch_perfils
  end

  def fetch_perfils
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # perfils = Perfil.page(page).per_page(per_page)
    perfils = Perfil.order("#{sort_column} #{sort_direction}")
    perfils = perfils.page(page).per(per_page)
    perfils = perfils.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id name idativo)
  end
end

class PerfilRoleDatatable < ApplicationDatatable
  delegate :edit_perfil_role_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    perfil_roles.map do |perfil_role|
      [].tap do |column|

        column << perfil_role.perfil.name
        column << perfil_role.role.name

        links = []
        # column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, perfil_role)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_perfil_role_path(perfil_role))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, perfil_role, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    PerfilRole.count
  end

  def total_entries
    perfil_roles.total_count
    # will_paginate
    # perfil_roles.total_entries
  end

  def perfil_roles
    @perfil_roles ||= fetch_perfil_roles
  end

  def fetch_perfil_roles
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # perfil_roles = PerfilRole.page(page).per_page(per_page)
    perfil_roles = PerfilRole.joins(:perfil).joins(:role).order("#{sort_column} #{sort_direction}")
    perfil_roles = perfil_roles.page(page).per(per_page)
    perfil_roles = perfil_roles.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(perfils.name roles.name)
  end
end

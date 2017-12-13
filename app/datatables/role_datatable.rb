class RoleDatatable < ApplicationDatatable
  delegate :edit_role_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    roles.map do |role|
      [].tap do |column|

        column << role.name
        column << role.resource_type
        column << role.resource_id

        links = []
        column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, role)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_role_path(role))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, role, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Role.count
  end

  def total_entries
    roles.total_count
    # will_paginate
    # roles.total_entries
  end

  def roles
    @roles ||= fetch_roles
  end

  def fetch_roles
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # roles = Role.page(page).per_page(per_page)
    roles = Role.order("#{sort_column} #{sort_direction}")
    roles = roles.page(page).per(per_page)
    roles = roles.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(name resource_type resource_id)
  end
end

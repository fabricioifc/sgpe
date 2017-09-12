class GridDatatable < ApplicationDatatable
  delegate :edit_grid_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    grids.map do |grid|
      [].tap do |column|

        column << grid.year
        column << grid.course.sigla + ' - ' + grid.course.name
        column << grid.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, grid)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_grid_path(grid))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, grid, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Grid.count
  end

  def total_entries
    grids.total_count
    # will_paginate
    # grids.total_entries
  end

  def grids
    @grids ||= fetch_grids
  end

  def fetch_grids
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # grids = Grid.page(page).per_page(per_page)
    grids = Grid.order("#{sort_column} #{sort_direction}")
    grids = grids.page(page).per(per_page)
    grids = grids.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(year active course_id)
  end
end

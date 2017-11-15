class PlanClassDatatable < ApplicationDatatable
  delegate :edit_plan_class_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    planclasses.map do |planclass|
      [].tap do |column|

        column << planclass.name
        column << planclass.ano
        column << planclass.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, planclass)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_plan_class_path(planclass))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, planclass, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    PlanClass.count
  end

  def total_entries
    planclasses.total_count
    # will_paginate
    # planclasses.total_entries
  end

  def planclasses
    @planclasses ||= fetch_planclasses
  end

  def fetch_planclasses
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # planclasses = PlanClass.page(page).per_page(per_page)
    planclasses = PlanClass.order("#{sort_column} #{sort_direction}")
    planclasses = planclasses.page(page).per(per_page)
    planclasses = planclasses.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(name ano active)
  end
end

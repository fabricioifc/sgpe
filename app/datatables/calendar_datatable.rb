class CalendarDatatable < ApplicationDatatable
  delegate :edit_calendar_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    calendars.map do |calendar|
      [].tap do |column|

        column << calendar.decorate.name
        # column << calendar.decorate.offer_name
        column << calendar.decorate.dt_inicio
        column << calendar.decorate.dt_fim
        column << calendar.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, calendar)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_calendar_path(calendar))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, calendar, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Calendar.count
  end

  def total_entries
    calendars.total_count
    # will_paginate
    # calendars.total_entries
  end

  def calendars
    @calendars ||= fetch_calendars
  end

  def fetch_calendars
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # calendars = Calendar.joins(:offer => {:grid => :course}).order("#{sort_column} #{sort_direction}")
    calendars = Calendar.order("#{sort_column} #{sort_direction}")
    calendars = calendars.page(page).per(per_page)
    calendars = calendars.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(calendars.name calendars.dt_inicio calendars.dt_fim)
  end
end

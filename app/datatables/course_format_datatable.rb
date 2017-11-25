class CourseFormatDatatable < ApplicationDatatable
  delegate :edit_course_format_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    course_formats.map do |course_format|
      [].tap do |column|

        column << course_format.id
        column << course_format.name
        column << course_format.minutos_aula

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, course_format)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_course_format_path(course_format))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, course_format, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    CourseFormat.count
  end

  def total_entries
    course_formats.total_count
    # will_paginate
    # course_formats.total_entries
  end

  def course_formats
    @course_formats ||= fetch_course_formats
  end

  def fetch_course_formats
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # course_formats = CourseFormat.page(page).per_page(per_page)
    course_formats = CourseFormat.order("#{sort_column} #{sort_direction}")
    course_formats = course_formats.page(page).per(per_page)
    course_formats = course_formats.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id name minutos_aula)
  end
end

class CourseDatatable < ApplicationDatatable
  delegate :edit_course_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    courses.map do |course|
      [].tap do |column|

        column << course.name
        column << course.sigla
        column << course.carga_horaria
        column << course.course_modality.description
        column << course.course_format.name
        column << course.course_offer.description
        column << course.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, course)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_course_path(course))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, course, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Course.count
  end

  def total_entries
    courses.total_count
    # will_paginate
    # courses.total_entries
  end

  def courses
    @courses ||= fetch_courses
  end

  def fetch_courses
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # courses = Course.page(page).per_page(per_page)
    courses = Course.order("#{sort_column} #{sort_direction}")
    courses = courses.page(page).per(per_page)
    courses = courses.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(name sigla active carga_horaria course_modality_id course_format_id)
  end
end

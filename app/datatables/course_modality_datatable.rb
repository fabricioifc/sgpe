class CourseModalityDatatable < ApplicationDatatable
  delegate :edit_course_modality_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    course_modalities.map do |course_modality|
      [].tap do |column|

        column << course_modality.id
        column << course_modality.sigla
        column << course_modality.description

        links = []
        column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, course_modality)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_course_modality_path(course_modality))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, course_modality, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    CourseModality.count
  end

  def total_entries
    course_modalities.total_count
    # will_paginate
    # course_modalities.total_entries
  end

  def course_modalities
    @course_modalities ||= fetch_course_modalities
  end

  def fetch_course_modalities
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # course_modalities = CourseModality.page(page).per_page(per_page)
    course_modalities = CourseModality.order("#{sort_column} #{sort_direction}")
    course_modalities = course_modalities.page(page).per(per_page)
    course_modalities = course_modalities.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id sigla description)
  end
end

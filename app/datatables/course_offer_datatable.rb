class CourseOfferDatatable < ApplicationDatatable
  delegate :edit_course_offer_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    courseoffers.map do |course_offer|
      [].tap do |column|

        column << course_offer.id
        column << course_offer.decorate.description
        column << course_offer.decorate.active

        links = []
        column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, course_offer)
        column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_course_offer_path(course_offer))
        column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, course_offer, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    CourseOffer.count
  end

  def total_entries
    courseoffers.total_count
    # will_paginate
    # courseoffers.total_entries
  end

  def courseoffers
    @courseoffers ||= fetch_courseoffers
  end

  def fetch_courseoffers
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # courseoffers = CourseOffer.page(page).per_page(per_page)
    courseoffers = CourseOffer.order("#{sort_column} #{sort_direction}")
    courseoffers = courseoffers.page(page).per(per_page)
    courseoffers = courseoffers.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id description active)
  end
end

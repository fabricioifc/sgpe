class OfferDatatable < ApplicationDatatable
  delegate :edit_offer_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    offers.map do |offer|
      [].tap do |column|

        column << offer.year
        column << offer.semestre
        column << offer.type_offer
        column << offer.grid.course.name

        links = []
        column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, offer)
        column << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_offer_path(offer))
        column << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, offer, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
      end
    end
  end

  # Returns the count of records.
  def count
    Offer.count
  end

  def total_entries
    offers.total_count
    # will_paginate
    # offers.total_entries
  end

  def offers
    @offers ||= fetch_offers
  end

  def fetch_offers
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # offers = Offer.page(page).per_page(per_page)
    offers = Offer.joins(:grid => :course).
      select('offers.id, offers.year, offers.semestre, offers.type_offer, offers.active, offers.grid_id, courses.name').
      order("#{sort_column} #{sort_direction}")
    offers = offers.page(page).per(per_page)
    offers = offers.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(offers.year offers.semestre offers.type_offer courses.name)
  end
end

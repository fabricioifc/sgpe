class TestDatatable < ApplicationDatatable
  delegate :edit_test_path, to: :@view

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    tests.map do |test|
      [].tap do |column|

        column << test.id
        column << test.title
        column << test.body
        column << test.active

        links = []
        links << link_to("<i class='fa fa-list fa-2'></i>".html_safe, test)
        links << link_to("<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, edit_test_path(test))
        links << link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, test, method: :delete, data: { confirm: 'Tem certeza?' })
        links << link_to("<i class='fa fa-file-pdf-o fa-2'></i>".html_safe, "tests/#{test.id}.pdf", method: :get, target: '_blank')
        column << links.join(" <span style='padding-right: 5px;'></span> ")
        
      end
    end
  end

  # Returns the count of records.
  def count
    Test.count
  end

  def total_entries
    tests.total_count
    # will_paginate
    # tests.total_entries
  end

  def tests
    @tests ||= fetch_tests
  end

  def fetch_tests
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # tests = Test.page(page).per_page(per_page)
    tests = Test.order("#{sort_column} #{sort_direction}")
    tests = tests.page(page).per(per_page)
    tests = tests.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(id title body active)
  end
end

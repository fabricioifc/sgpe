class TestDatatable < ApplicationDatatable
  delegate :edit_test_path, to: :@view

    private

    def data
      tests.map do |test|
        [].tap do |column|
          column << test.title
          column << test.body

          links = []
          column << link_to("<span class='glyphicon glyphicon-th-list'></span>".html_safe, test)
          column << link_to("<span class='glyphicon glyphicon-edit'></span>".html_safe, edit_test_path(test))
          column << link_to("<span class='glyphicon glyphicon-remove'></span>".html_safe, test, method: :delete, data: { confirm: 'Tem certeza?' })
          # column << links.join(" | ")
        end
      end
    end

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
      # tests = User.page(page).per_page(per_page)
      tests = Test.order("#{sort_column} #{sort_direction}")
      tests = tests.page(page).per(per_page)
      tests = tests.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
      tests
    end

    def columns
      # (title last_name email phone_number)
      %w(title body)
    end
end

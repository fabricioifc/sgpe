class DisciplineDatatable < ApplicationDatatable
  delegate :edit_discipline_path, to: :@view

    private

    def data
      disciplines.map do |discipline|
        [].tap do |column|
          column << discipline.id
          column << discipline.title
          column << discipline.description
          column << discipline.active

          links = []
          column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, discipline)
          column << link_to("<span class='glyphicon glyphicon-edit'></span>".html_safe, edit_discipline_path(discipline))
          column << link_to("<span class='glyphicon glyphicon-remove'></span>".html_safe, discipline, method: :delete, data: { confirm: 'Tem certeza?' })
          # column << links.join(" | ")
        end
      end
    end

    def count
      Discipline.count
    end

    def total_entries
      disciplines.total_count
      # will_paginate
      # disciplines.total_entries
    end

    def disciplines
      @disciplines ||= fetch_disciplines
    end

    def fetch_disciplines
      search_string = []
      columns.each do |term|
        search_string << "lower(#{term}::text) like lower(:search)"
      end

      # will_paginate
      # disciplines = User.page(page).per_page(per_page)
      disciplines = Discipline.order("#{sort_column} #{sort_direction}")
      disciplines = disciplines.page(page).per(per_page)
      disciplines = disciplines.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
      disciplines
    end

    def columns
      # (title last_name email phone_number)
      %w(id title description active)
    end
end

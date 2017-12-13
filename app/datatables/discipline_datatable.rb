class DisciplineDatatable < ApplicationDatatable
  delegate :edit_discipline_path, to: :@view

    private

    def data
      disciplines.map do |discipline|
        [].tap do |column|
          column << discipline.title
          column << discipline.sigla
          column << discipline.decorate.active
          column << discipline.decorate.especial

          links = []
          column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, discipline)
          column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_discipline_path(discipline))
          column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, discipline, method: :delete, data: { confirm: 'Tem certeza?' })
          # column << links.join(" <span style='padding-right: 5px;'></span> ")
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
      %w(title sigla active especial)
    end
end

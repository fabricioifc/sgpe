class UserDatatable < ApplicationDatatable
  delegate :edit_user_registration_path, :form_for, to: :@view

  def initialize(view, current_user, update_perfils_users_path)
    @view = view
    @current_user = current_user
    @update_perfils_users_path = update_perfils_users_path
  end

  private

  def data
    # binding.pry
    users.map do |user|
      [].tap do |column|

        column << link_to(user.name.html_safe, user)
        column << user.username
        column << user.email
        column << user.decorate.active
        # column << @view.render('users/user_perfis.html.erb', user: user)

        # if user == @current_user
        #   column << ''
        # else
        #   column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, user, :data => { :confirm => "Tem certeza?" }, :method => :delete, :class => '')
        # end

        # column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, user)
      end
    end
  end

  # Returns the count of records.
  def count
    User.count
  end

  def total_entries
    users.total_count
    # will_paginate
    # users.total_entries
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    search_string = []
    columns.each do |term|
      search_string << "lower(#{term}::text) like lower(:search)"
    end

    # will_paginate
    # users = user.page(page).per_page(per_page)
    users = User.order("#{sort_column} #{sort_direction}")
    users = users.page(page).per(per_page)
    users = users.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  # The columns needs to be the same list of searchable items and IN ORDER that they will appear in Data.
  def columns
    %w(name username email)
  end
end

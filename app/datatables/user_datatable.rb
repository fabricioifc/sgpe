class UserDatatable < ApplicationDatatable
  delegate :edit_user_path, to: :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  private

  # Loop through memoized collection and build the columns.
  # If extracting from a view, be sure to add delegates
  # and to also clean up and inject each column into the column var.
  # Also, if you have multiple items (links) in a single column, you
  # will need to create a separate variable and join them accordingly
  # when pushing to the column array
  def data
    # binding.pry
    users.map do |user|
      [].tap do |column|

        column << user.name
        # column << user.username
        column << user.email
        column << @view.render('users/user_perfis.html.erb', user: user)

        if user == @current_user
          column << ''
        else
          column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, user, :data => { :confirm => "Tem certeza?" }, :method => :delete, :class => 'btn btn-sm btn-danger')
        end

        # links = []
        # column << link_to("<i class='fa fa-list fa-2 text-info'></i>".html_safe, user)
        # column << link_to("<i class='fa fa-pencil-square-o fa-2 text-warning'></i>".html_safe, edit_user_path(user))
        # column << link_to("<i class='fa fa-trash-o fa-2 text-danger'></i>".html_safe, user, method: :delete, data: { confirm: 'Tem certeza?' })
        # column << links.join(" <span style='padding-right: 5px;'></span> ")
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

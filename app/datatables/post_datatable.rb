class PostDatatable < ApplicationDatatable
  delegate :edit_post_path, to: :@view

    private

    def data
      posts.map do |post|
        [].tap do |column|
          column << post.id
          column << post.title

          links = []
          column << link_to("<i class='fa fa-list fa-2'></i>".html_safe, post)
          column << link_to("<span class='glyphicon glyphicon-edit'></span>".html_safe, edit_post_path(post))
          column << link_to("<span class='glyphicon glyphicon-remove'></span>".html_safe, post, method: :delete, data: { confirm: 'Are you sure?' })
          # column << links.join(" | ")
        end
      end
    end

    def count
      Post.count
    end

    def total_entries
      posts.total_count
      # will_paginate
      # posts.total_entries
    end

    def posts
      @posts ||= fetch_posts
    end

    def fetch_posts
      search_string = []
      columns.each do |term|
        search_string << "lower(#{term}::text) like lower(:search)"
      end

      # will_paginate
      # posts = User.page(page).per_page(per_page)
      posts = Post.order("#{sort_column} #{sort_direction}")
      posts = posts.page(page).per(per_page)
      posts = posts.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
      posts
    end

    def columns
      # (title last_name email phone_number)]
      %w(id title)
    end
end

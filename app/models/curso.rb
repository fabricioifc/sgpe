class Curso < ApplicationRecord
  belongs_to :user
  paginates_per 2

  validates :title, :sigla, :description, presence:true

  # def self.search(term, page)
  #   if term
  #     where('title LIKE ?', "%#{term}%").paginate(page: page).order('id DESC')
  #   else
  #     paginate(page: page).order('id DESC')
  #   end
  # end
end

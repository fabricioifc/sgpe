class User < ApplicationRecord
  # rolify

  validates :name, presence:true, length: 0..70

  has_and_belongs_to_many :perfils, :join_table => :users_perfils
  # enum role: [:user, :vip, :admin]
  # after_initialize :set_default_role, :if => :new_record?
  #
  # def set_default_role
  #   self.role ||= :user
  # end

  # after_create :assign_default_role
  #
  # def assign_default_role
  #   self.add_role(:usuario) if self.roles.blank?
  # end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # mount_uploader :avatar, PictureUploader
  mount_uploader :avatar, AvatarUploader

end

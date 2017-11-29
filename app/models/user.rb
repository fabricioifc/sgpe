class User < ApplicationRecord
  # rolify
  has_and_belongs_to_many :perfils, :join_table => :users_perfils
  has_many :offer_disciplines
  has_many :plans, :class_name => 'Plan'
  has_many :plans_parecer, :class_name => 'Plan', :foreign_key => 'user_parecer_id'
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
  if Rails.env.production?
    devise :database_authenticatable, :async, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable, :validatable,
           :authentication_keys => [:login]
   else
     devise :database_authenticatable, :registerable, :confirmable,
            :recoverable, :rememberable, :trackable, :validatable,
            :authentication_keys => [:login]
   end

  # mount_uploader :avatar, PictureUploader
  mount_uploader :avatar, AvatarUploader

  # Permitir o atributo login, que poderá ser username ou email
  attr_accessor :login

  validates :name, presence:true, length: 5..150
  validates :username, presence:true, length: 5..100, uniqueness:true#, on: :create
  # Permitir apenas numetros, letras, underline e ponto. Não permitir apenas números
  validates_format_of :username, with: /^(?![0-9]*$)[a-zA-Z0-9_.]+$/, :multiline => true#, on: :create

  protected

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions attributes = {}
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors required_attributes, attributes, error = :invalid
    (case_insensitive_keys || []).each {|k| attributes[k].try(:downcase!)}

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if {|_key, value| value.blank?}

    if attributes.keys.size == required_attributes.size
      if attributes.key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record login
    where(["username = :value OR email = :value", {value: login}]).first
  end

end

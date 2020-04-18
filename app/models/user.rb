class User < ApplicationRecord
  acts_as_token_authenticatable
  # rolify
  has_and_belongs_to_many :perfils, :join_table => :users_perfils
  has_many :plans, :class_name => 'Plan'
  has_many :plans_parecer, :class_name => 'Plan', :foreign_key => 'user_parecer_id'

  # Disciplinas como primeiro professor
  has_many :offer_disciplines
  # Disciplinas como segundo professor
  has_many :offer_disciplines_second, :class_name => 'OfferDiscipline', :foreign_key => 'second_user_id'

  # before_create :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable
  if Rails.env.production?
    devise :invitable, :database_authenticatable, :async, :confirmable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :authentication_keys => [:login]
   else
     devise :invitable, :database_authenticatable, :confirmable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable,
            :authentication_keys => [:login]
   end

  has_one_attached :avatar
  # mount_uploader :avatar, AvatarUploader

  # Permitir o atributo login, que poderá ser username ou email
  attr_accessor :login

  # validates :name, presence:true, length: 0..150
  # validates :username, presence:true, length: 5..100, uniqueness:true#, on: :create
  validates :username, length: 3..100, unless: Proc.new { |a| a.username.blank? }
  validates :username, uniqueness:true, unless: Proc.new { |a| a.username.blank? }
  # validates :siape, uniqueness:true, presence:true, on: :update

  # Permitir apenas numetros, letras, underline e ponto. Não permitir apenas números
  validates_format_of :username, with: /^(?![0-9]*$)[a-zA-Z0-9_.]+$/, :multiline => true, unless: Proc.new { |a| a.username.blank? }

  def decorate
    @user ||= UserDecorator.new self
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(authentication_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(authentication_token: nil)
  end

  protected

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

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

# private
#
#   def set_default_role
#     self.perfils ||= Perfil.find_by_name('Professor')
#   end

end

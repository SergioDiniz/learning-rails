class User < ActiveRecord::Base
  # attr_accessor :full_name, :email, :password, :location, :bio

  validates_presence_of :full_name, :email, :location
  # validates_confirmation_of :password
  # validates_presence_of :password_confirmation
  validates_length_of :bio, minimum: 3, allow_blank: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email
  has_secure_password

  before_create :generate_token

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end
end

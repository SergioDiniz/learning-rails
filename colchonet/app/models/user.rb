class User < ActiveRecord::Base
  # attr_accessor :full_name, :email, :password, :location, :bio
  
  validates_presence_of :full_name, :email, :password, :location
  validates_confirmation_of :password
  validates_presence_of :password_confirmation
  validates_length_of :bio, minimum: 3, allow_blank: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email
end

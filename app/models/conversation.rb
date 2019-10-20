# require 'bcrypt'

class Conversation < ApplicationRecord
  # include BCrypt
  has_secure_password


  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :topic, presence: true, uniqueness: true, case_sensitive: false

  # attr_accessor :skip_password_validation

  private

  # def password_required?
  #   binding.pry
  #   return false if skip_password_validation
  #   super
  # end

  # validates :password, length: { minimum: 3 }, allow_nil: true
  # validates :password, presence: true, on: :create
  # validates :password, length: { minimum: 8 }, allow_blank: true

  # def password
  #   binding.pry
  #   @password ||= Password.new(password_hash)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end

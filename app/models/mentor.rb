require 'securerandom'
class Mentor < ApplicationRecord
  has_secure_password
  has_many :entors

  def login
    self.access_token = SecureRandom.alphanumeric(10)
    self.save
  end
end
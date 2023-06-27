class User < ApplicationRecord
  attr_accessor :remember_token

  # can write email = email.downcase but can write
  # email.downcase! to modify the email attribute directly
  # here "!" is special syntax to modify directly data
  # can use for other variables
  before_save { email.downcase!}

  # Regex to VALIDATION
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validate for attribute name with presence (no empty and no only space), max length <= 50
  validates :name, {presence: true, length: {maximum: 50}}

  #validate for attribute email with presence(no empty and no only space), max length <=255
  # and format accept regex VALID and no distinct case insensitive
  validates :email, {presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }}

  # use hash function to mapping password -> hashed passwod(save in db)
  # method will included -> virtually pair {password, password_confirmation}
  # password_disgest -> save in db
  # method authenticate to authentication for user log in
  has_secure_password

  # validate for attribute password :)) i don't want to write any more because it is the same with code above
  validates :password, {presence: true, length: {minimum: 6}}

  # Returns the hash digest of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a new random token
  def self.new_token
    SecureRandom.urlsafe_base64()
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # return true if the given token matches the digest token
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end

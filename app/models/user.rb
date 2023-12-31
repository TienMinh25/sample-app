class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :downcase_email
  before_create :create_activation_digest

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

  class << self
    # Returns the hash digest of the given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a new random token
    def new_token
      SecureRandom.urlsafe_base64()
    end
  end

  scope :activated_users, -> {where(activated: true)}

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
    remember_digest
  end

  # return true if the given token matches the digest token
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user
  def forget
    update_attribute :remember_digest, nil
  end

  # Returns a session token to prevent session hijacking
  # Reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Sends activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Actives an account
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    part_of_feed = "relationships.follower_id = :id or microposts.user_id = :id"
    Micropost.left_outer_joins(user: :followers).where(part_of_feed, { id: id }).distinct
      .includes(:user, image_attachment: :blob)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

  # Convert email to all downcase
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end

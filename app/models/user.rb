class User < ActiveRecord::Base
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  scope :confirmed, -> {where.not(confirmed_at: nil)}
  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, minimum: 30, allow_blank: false
  validates_uniqueness_of :email

  validate :email_format

  has_secure_password
  has_many :rooms

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?
    self.confirmed_at = Time.current
    self.confirmation_token = ""
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

  def self.authenticate(email,password)
    confirmed.find_by(email: email).try(:authenticate, password)
  end

  private
  def email_format
    errors.add(:email,:invalid) unless email.match(EMAIL_REGEXP)
  end
end
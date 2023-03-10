class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  has_many :comments, class_name: 'Comment', foreign_key: 'user_id'
  has_many :articles, class_name: "Article", foreign_key: "user_id"

  before_save {self.email = email.downcase}

  has_secure_password
end
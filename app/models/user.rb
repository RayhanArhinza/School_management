
class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  belongs_to :role

  has_one :guru, foreign_key: 'email', primary_key: 'email'


  validates :name, presence: true
  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                      length: { minimum: 6 },
                      on: :create

  def self.authenticate(email, password)
    user = find_by(email: email.to_s.downcase)
    user && user.authenticate(password)
  end
end
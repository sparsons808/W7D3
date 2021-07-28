# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_obj = BCrypt::Password.new(self.password_digest)
    password_obj.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nill
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  has_many :goals,
    foreign_key: :author_id,
    class_name: :Goal
end

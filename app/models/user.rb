# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  attr_accessor :reset_token

  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }

  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def password_reset_expired?
    reset_sent_at < 24.hours.ago
  end

  def create_reset_digest
    self.reset_token = new_token
    update_attribute(:reset_digest,  digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def destroy_reset_digest
    self.reset_token = nil
    update_attribute(:reset_digest,  digest(reset_token))
    update_attribute(:reset_sent_at, nil)
  end

  def authenticated?(token)
    digest = send(:reset_digest)
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end
end

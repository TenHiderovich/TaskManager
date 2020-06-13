# frozen_string_literal: true

module TokenHelper
  def new_reset_token
    self.reset_token = loop do
      token = SecureRandom.urlsafe_base64
      break token unless User.exists?(reset_digest: token)
    end
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def password_reset_expired?
    time_validity_token = 24
    reset_sent_at < time_validity_token.hours.ago
  end

  def create_reset_digest!
    new_reset_token
    update(reset_digest: digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def destroy_reset_digest!
    self.reset_token = nil
    update(reset_digest: nil)
  end

  def authenticated_reset_token?(token)
    digest = reset_digest
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end
end

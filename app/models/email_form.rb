# frozen_string_literal: true

class EmailForm
  include ActiveModel::Model

  attr_accessor(
    :email
  )

  validates :email, presence: true, format: { with: /@/ }
  validate :user_valid?

  def user
    User.find_by(email: email)
  end

  private

  # эта конструкция просто сгенерит ошибку что бы в password_resets_controller не было
  # отправки письма. Визуально не будет понятно прошла ли почта валидацию ил нет, сообщение о том что нужно проверить email
  # будет в любом случае. Поэтому мамкин хацкер уже не сможет со 100% вероятностью сказть что пользователь с таким email
  # зарегистрирован
  def user_valid?
    errors.add(:email) if user.blank?
  end
end

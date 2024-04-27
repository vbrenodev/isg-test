# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: %i[create update]
  validates :password_confirmation, length: { minimum: 6 }, on: %i[create update]
  validates :password, confirmation: { on: %i[create update] }

  default_scope -> { where(deleted_at: nil) }

  def destroy
    update_column(deleted_at: Time.current) # rubocop:disable Rails/SkipsModelValidations
  end

  def deleted?
    deleted_at.present?
  end
end

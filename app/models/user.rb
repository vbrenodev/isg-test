# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, on: %i[create update]
  validates :password_confirmation, length: { minimum: 6 }, on: %i[create update]
  validates_confirmation_of :password, on: %i[create update]

  default_scope -> { where(deleted_at: nil) }

  def destroy
    update_attribute(:deleted_at, Time.zone.now)
  end

  def deleted?
    deleted_at.present?
  end
end

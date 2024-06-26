# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: %i[create]
  validates :password_confirmation, length: { minimum: 6 }, on: %i[create]
  validates :password, confirmation: { on: %i[create] }

  default_scope -> { where(deleted_at: nil) }

  def destroy
    update_attribute(:deleted_at, Time.zone.now) # rubocop:disable Rails/SkipsModelValidations
  end

  def deleted?
    deleted_at.present?
  end
end

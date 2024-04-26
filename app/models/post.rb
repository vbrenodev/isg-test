# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :text, presence: true, length: { maximum: 1_000 }

  default_scope -> { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.zone.now)
  end

  def deleted?
    deleted_at.present?
  end
end

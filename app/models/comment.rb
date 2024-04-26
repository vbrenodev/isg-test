# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post

  validates :name, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 1_000 }

  default_scope -> { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.zone.now)
  end

  def deleted?
    deleted_at.present?
  end
end

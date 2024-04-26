# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
end

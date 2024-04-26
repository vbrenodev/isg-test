# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :deleted_at
  end
end

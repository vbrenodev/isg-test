# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :text
      t.datetime :deleted_at
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end

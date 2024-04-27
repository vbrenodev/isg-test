# frozen_string_literal: true

json.comments do
  json.array! @comments do |comment|
    json.id comment.id
    json.name comment.name
    json.text comment.text
    json.deleted_at comment.deleted_at
    json.created_at comment.created_at
    json.updated_at comment.updated_at
  end
end

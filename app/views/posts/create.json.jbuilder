# frozen_string_literal: true

json.message @message
json.post do
  json.id @post.id
  json.title @post.title
  json.text @post.text
  json.created_at @post.created_at
  json.updated_at @post.updated_at
end

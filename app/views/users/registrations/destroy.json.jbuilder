# frozen_string_literal: true

json.message @message
json.user do
  json.id resource.id
  json.name resource.name
  json.email resource.email
end

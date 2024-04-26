# frozen_string_literal: true

json.message 'Successfully logged in.'
json.user do
  json.id current_user.id
  json.name current_user.name
  json.email current_user.email
end

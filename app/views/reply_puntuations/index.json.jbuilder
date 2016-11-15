json.array!(@reply_puntuations) do |reply_puntuation|
  json.extract! reply_puntuation, :id, :reply_id, :user_id
  json.url reply_puntuation_url(reply_puntuation, format: :json)
end

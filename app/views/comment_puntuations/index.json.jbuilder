json.array!(@comment_puntuations) do |comment_puntuation|
  json.extract! comment_puntuation, :id, :comment_id, :user_id
  json.url comment_puntuation_url(comment_puntuation, format: :json)
end

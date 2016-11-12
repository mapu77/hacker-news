json.array!(@puntuations) do |puntuation|
  json.extract! puntuation, :id, :user_id, :contribution_id
  json.url puntuation_url(puntuation, format: :json)
end

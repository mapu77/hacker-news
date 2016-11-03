json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :title, :url, :text, :puntuation, :user_id
  json.url contribution_url(contribution, format: :json)
end

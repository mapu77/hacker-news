json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :title, :content, :user_id, :created_at
  json.url contribution_url(contribution, format: :json)
end

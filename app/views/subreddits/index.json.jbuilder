json.array!(@subreddits) do |subreddit|
  json.extract! subreddit, :id, :title
  json.url subreddit_url(subreddit, format: :json)
end

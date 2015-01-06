class AddSubredditReferencesToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :subreddit, index: true
    add_foreign_key :submissions, :subreddits
  end
end

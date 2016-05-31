class AddUserRefToSubreddits < ActiveRecord::Migration
  def change
    add_reference :subreddits, :user, index: true, foreign_key: true
  end
end

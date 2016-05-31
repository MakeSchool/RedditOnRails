class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subreddit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

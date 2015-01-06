class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name
      t.references :moderator, index: true

      t.timestamps null: false
    end
    add_foreign_key :subreddits, :moderators
  end
end

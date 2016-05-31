class AddSlugToSubreddits < ActiveRecord::Migration
  def change
    add_column :subreddits, :slug, :string
    add_index :subreddits, :slug, unique: true
    add_index :subreddits, :title, unique: true
  end
end

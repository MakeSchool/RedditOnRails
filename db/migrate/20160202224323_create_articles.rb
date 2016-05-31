class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :url
      t.references :subreddit, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :articles, :title
  end
end

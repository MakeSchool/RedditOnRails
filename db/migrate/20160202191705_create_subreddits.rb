class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :title

      t.timestamps null: false
    end
    add_index :subreddits, :title
  end
end

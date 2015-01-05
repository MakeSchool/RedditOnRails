class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :title
      t.references :postable, index: true, polymorphic: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :submissions, :postables
    add_foreign_key :submissions, :users
    add_index :submissions, [:user_id, :created_at]
  end
end

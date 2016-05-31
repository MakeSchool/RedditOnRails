class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :article, index: true, foreign_key: true
      t.integer :value

      t.timestamps null: false
    end
  end
end

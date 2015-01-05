class AddScoreToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :score, :int, default: 0
  end
end

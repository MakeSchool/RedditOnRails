class RemoveArticleFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :article, :string
    add_reference :comments, :commentable, polymorphic: true, index: true
  end
end

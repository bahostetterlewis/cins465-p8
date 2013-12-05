class AddOldLengthToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :old_length, :integer
  end
end

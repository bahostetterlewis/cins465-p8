class AddNewLengthToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :new_length, :integer
  end
end

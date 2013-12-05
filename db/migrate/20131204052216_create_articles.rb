class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :summary
      t.string :url
      t.integer :pre_length
      t.integer :post_length

      t.timestamps
    end
  end
end

class AddCompressionRateToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :compression_rate, :float
  end
end

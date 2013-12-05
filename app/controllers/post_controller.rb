require 'summerizer'

class PostController < ActionController::Base
  def new
  end

  #def process
  #  params.require(:url)
  #  summary, old_length = Summerizer.get_summary params[:url]
  #  article = Article.new
  #  article.summary = summary
  #  article.url = params[:url]
  #  article.new_length = summary.length
  #  article.old_length = old_length
  #  article.compression_rate = 100 - ((summary.length.to_f / old_length.to_f) * 100)
  #  article.save
  #  respond_to do |format|
  #    format.html{}
  #    format.json{}
  #  end
  #end
end
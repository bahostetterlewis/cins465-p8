class Post < ActiveRecord::Base
  has_one :article
  belongs_to :user
end

class Post < ActiveRecord::Base
  attr_accessible :title
  acts_as_taggable
end

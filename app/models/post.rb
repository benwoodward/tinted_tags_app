require 'tag_tinter'

class Post < ActiveRecord::Base
  attr_accessible :title, :tag_list
  acts_as_taggable
  after_save :update_tints, if: :tag_list_changed?

  private

  def update_tints
    TagTinter.new('black', 'white').update_tints
  end
end

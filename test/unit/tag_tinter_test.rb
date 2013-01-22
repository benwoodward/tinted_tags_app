require_relative '../test_helper'
require 'tag_tinter'

class TagTinterTest < ActiveSupport::TestCase
  include ActsAsTaggableOn

  test "calculate hex color representation of a tag use percentage" do
    Post.delete_all
    Tag.delete_all
    Tagging.delete_all

    tags = ['red', 'yellow', 'green', 'blue']
    tags.each do |tag|
      Post.create(title: 'title', tag_list: tag)
    end
    TagTinter.new('black', 'white').update_colours

    # each tag has 25% usage, '#bfbfbf' is black with 25% white
    assert Tag.first.tag_colour == '#bfbfbf', Tag.first.tag_colour

    Post.delete_all
    Tag.delete_all
    Tagging.delete_all

    tags = ['red', 'yellow', 'green', 'blue', 'orange']
    tags.each do |tag|
      Post.create(title: 'title', tag_list: tag)
    end
    TagTinter.new('black', 'white').update_colours

    # each tag has 20% usage, '#cccccc' is black with 20% white
    assert Tag.first.tag_colour == '#cccccc', Tag.first.tag_colour
  end
end

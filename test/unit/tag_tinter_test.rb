require_relative '../test_helper'
require 'tag_tinter'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

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
    TagTinter.new('black', 'white').update_tints

    # each tag has 25% usage, '#bfbfbf' is black with 25% white
    assert Tag.first.tag_colour == '#bfbfbf', Tag.first.tag_colour

    Post.delete_all
    Tag.delete_all
    Tagging.delete_all

    tags = ['red', 'yellow', 'green', 'blue', 'orange']
    tags.each do |tag|
      Post.create(title: 'title', tag_list: tag)
    end
    TagTinter.new('black', 'white').update_tints

    # each tag has 20% usage, '#cccccc' is black with 20% white
    assert Tag.first.tag_colour == '#cccccc', Tag.first.tag_colour
  end

  test "calculate percentage within range of min to max taggings" do
    DatabaseCleaner.clean
    Post.delete_all
    10.times { Post.create(title: 'title', tag_list: 'max') }
    5.times { Post.create(title: 'title', tag_list: 'median') }
    1.times { Post.create(title: 'title', tag_list: 'min') }
    TagTinter.new('black', 'white', tint_strategy: :rated_as_range).update_tints
    # 'median' tag should be 44% (1 being 0%, 10 being 100%)
    t = Tag.where(name: 'median').first
    assert t.tag_colour == '#8e8e8e', t.tag_colour
  end
end

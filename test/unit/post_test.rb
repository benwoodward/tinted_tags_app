require_relative '../test_helper'

class PostTest < ActiveSupport::TestCase
  test "posts have tags" do
    p = Post.new
    p.tag_list = 'banana,orange,blueberry'
    p.save

    assigned_tags = p.tags.collect { |t| t.name }
    assert assigned_tags.include?('orange'), assigned_tags.join(',')
  end
end

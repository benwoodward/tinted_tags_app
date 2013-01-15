require_relative '../test_helper'

class PostTest < ActiveSupport::TestCase
  test "posts have tags" do
    p = Post.new
    p.tag_list = 'banana,orange,blueberry'
    p.save
    tags = p.tags.collect { |t| t.name }
    assert tags.include?('orange'), tags.join(',')
  end
end

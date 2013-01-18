require_relative '../test_helper'

class TagTest < ActiveSupport::TestCase
  include ActsAsTaggableOn

  test "tags have tag_colour attribute" do
    assert Tag.new.has_attribute?(:tag_colour), Tag.column_names.to_s
  end

end

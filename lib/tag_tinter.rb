require 'compass'

class TagTinter
  def initialize(col1, col2)
    @colour1 = col1
    @colour2 = col2
  end

  def update_tints
    total = Post.tag_counts_on(:tags).map(&:count).inject(:+)

    Post.tag_counts_on(:tags).each do |tag|
      count = tag.count
      percent = ((count * 100) / total).round(2)
      tag.tag_colour = evaluate("mix(#{@colour1}, #{@colour2}, #{percent})")
      tag.save
    end
  end

  private

  def evaluate(value)
    Sass::Script::Parser.parse(value, 0, 0).perform(Sass::Environment.new).to_s
  end
end

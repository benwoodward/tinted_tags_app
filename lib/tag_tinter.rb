require 'compass'

class TagTinter
  def initialize(col1, col2)
    @colour1 = col1
    @colour2 = col2
  end

  def update_colours
    total = ActsAsTaggableOn::Tagging.count

    ActsAsTaggableOn::Tag.all.each do |tag|
      count = tag.taggings.count
      percent = ((count * 100) / total).round(2)
      puts percent
      puts "total: #{total}"
      tag.tag_colour = evaluate("mix(#{@colour1}, #{@colour2}, #{percent})")
      tag.save
    end
  end

  private

  def evaluate(value)
    Sass::Script::Parser.parse(value, 0, 0).perform(Sass::Environment.new).to_s
  end
end

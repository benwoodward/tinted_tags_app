class AddTagColourToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_colour, :string
  end
end

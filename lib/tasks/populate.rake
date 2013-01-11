namespace :db do
  desc 'Erase and fill database with tagged posts'
  task populate: :environment do
    require 'faker'

    tags = ['red', 'blue', 'green', 'orange', 'pink', 'purple', 'turquoise', 'yellow']

    Post.delete_all

    100.times do
      p = Post.new
      p.title = Faker::Lorem.sentence(word_count = 4, supplemental = false)
      p.tag_list = tags.sample(rand(8)).join(',')
      puts p.tags
      p.save
    end
  end
end

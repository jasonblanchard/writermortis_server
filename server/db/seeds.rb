# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

user1 = User.first_or_create(:email => "jason@example.com", :password => "testpass", :password_confirmation => "testpass")
user2 = User.first_or_create(:email => "user2@example.com", :password => "testpass", :password_confirmation => "testpass")

story = user1.stories.first_or_create(:title => "My first story")

if story.pieces.empty?
  texts = ["Once upon a time", " there was a little cat named hamburger"]
  users = [user1, user2]

  texts.each_with_index do |text, index|
    story.pieces.create(:text => text, :user => users[index])
  end
end

require 'launchy'

puts "Input your email:"
email = gets.chomp
raise 'You are not a valid user!' unless User.exists?(['email = ?', email])
user = User.find_by(email: email)

puts "\n"


puts "What do you want to do?"
puts "0. Create shortened URL"
puts "1. Visit shortened URL"
choice = gets.chomp

raise 'Invalid choice' unless ['1','0'].include?(choice)

case choice
when '0'
  puts "Type in your long url"
  long_url = gets.chomp
  ShortenedUrl.create!(user,long_url)
  puts "Short url is: #{ShortenedUrl.last.short_url}"
  puts "Goodbye!"
when '1'
  puts "Type in the shortened URL"
  shortened_url = gets.chomp
  short_url = ShortenedUrl.find_by(short_url: shortened_url)
  long_url = short_url.long_url
  puts "Launching #{long_url}"
  Launchy.open(long_url)
  Visit.record_visit!(user, short_url)
  num_visits = short_url.num_clicks
  puts "People have visited this URL #{num_visits} times"
  puts "Goodbye!"
end

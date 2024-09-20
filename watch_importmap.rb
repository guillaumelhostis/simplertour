# watch_importmap.rb
require 'listen'

listener = Listen.to('app/javascript/') do |modified, added, removed|
  puts "Detected changes in JavaScript files. Recompiling assets..."
  system('rails assets:precompile')
end

listener.start
sleep

require 'open-uri'
open('http_access_log', 'wb') do |file|
  file << open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log').read
end
puts "finished"

puts "Now Reading File."
rules = {}
rules[:status] = 404           # only accept hits where the status response is 404
log_results = []


fourerr = {
rules[:status] => 404           # only accept hits where the status response is 404
}
require 'apache_log_parser'
'apache_log_parser'
log_results.push(ApacheLogParser.parse("http_access_log", fourerr) do |parsed|
  parsed[:ip]         #=> "12.12.12.12"
  parsed[:date]       #=> "21/Jan/2010"
  parsed[:day]        #=> 21
  parsed[:month]      #=> "Jan"
  parsed[:year]       #=> 2010
  parsed[:hour]       #=> 14
  parsed[:zone]       #=> "-0800"
  parsed[:method]     #=> "GET"
  parsed[:http_ver]   #=> "1.1"
  parsed[:resource]   #=> "/some/page.php"
  parsed[:status]     #=> 200
  parsed[:size]       #=> "7047"
  parsed[:referer]    #=> "-"
  parsed[:user_agent] #=> "Mozilla/5.0 (Macintosh; U; Intel..."
end)
puts "#{log_results}"























  #Once you download the file, you will be parsing the file in order to answer several questions:
#How many total requests were made in the time period represented in the log?
#How many requests were made on each day?
#What percentage of the requests were not successful (any 4xx status code)?
#What percentage of the requests were redirected elsewhere (any 3xx codes)?
#What was the most-requested file?
#What was the least-requested file?

require 'open-uri'
open('http_access_log', 'wb') do |file|
  file << open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log').read
end
print "finished"

  #Once you download the file, you will be parsing the file in order to answer several questions:
#How many total requests were made in the time period represented in the log?
#How many requests were made on each day?
#What percentage of the requests were not successful (any 4xx status code)?
#What percentage of the requests were redirected elsewhere (any 3xx codes)?
#What was the most-requested file?
#What was the least-requested file?

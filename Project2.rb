puts "Now downloading file."
require 'open-uri'
open('http_access_log', 'wb') do |file|
  file << open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log').read
end
puts "Now doing a thing."

dlog = File.readlines "http_access_log"
def parse(logs) 

  apache_regex = /\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/

 date = []
  logs.each do |log|
    parser = log.scan(apache_regex)[0]

    # If can't parse the log line for any reason.
    if log.scan(apache_regex)[0].nil?
     
      next
    end

     parse = 
        {
          :date       => parser[1]
        }
    date << parse
  end

  return date
end
date_log = []
date_log << parse(dlog)
puts "Now doing another thing."
flog = File.readlines "http_access_log" 
def parse(logs) 

  apache_regex = /\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/

 file = []
  logs.each do |log|
    parser = log.scan(apache_regex)[0]

    # If can't parse the log line for any reason.
    if log.scan(apache_regex)[0].nil?
     
      next
    end

     parse = 
        {
         :file       => parser[3]
        }
    file << parse
  end

  return file
end 
file_log = []
file_log << parse(flog)
puts "Now doing someother ting."
clog = File.readlines "http_access_log"
def parse(logs) 

  apache_regex = /\A(?<ip_address>\S+) \S+ \S+ \[(?<time>[^\]]+)\] "(?<method>GET|POST) (?<url>\S+) \S+?" (?<status>\d+) (?<bytes>\S+)/

 code = []
  logs.each do |log|
    parser = log.scan(apache_regex)[0]

    # If can't parse the log line for any reason.
    if log.scan(apache_regex)[0].nil?
     
      next
    end

     parse = 
        {
		  :code       => parser[4]
        }
    code << parse
  end

  return code
end
code_log = []
code_log << parse(clog)


#/(:[u][r]._[a-z]{4}=>)"\d{3}"/


print "#{file_log}"



count = 0
File.open("http_access_log") {|f| count = f.read.count("\n")}

puts "#{count}"





  #Once you download the file, you will be parsing the file in order to answer several questions:
#How many total requests were made in the time period represented in the log?
#How many requests were made on each day?
#What percentage of the requests were not successful (any 4xx status code)?
#What percentage of the requests were redirected elsewhere (any 3xx codes)?
#What was the most-requested file?
#What was the least-requested file?

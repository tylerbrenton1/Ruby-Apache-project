puts "Now downloading file."
require 'open-uri'
open('http_access_log', 'wb') do |file|
  file << open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log').read
end
puts "Now doing a thing."
#This pulls out the date
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
#This pulls out the files requested
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
file_log = parse(flog)
file_name = file_log.group_by { |n| n }.values.max_by(&:size).first
puts " The most requested file is #{file_name}"






#This pulls out the respones code
puts "Now doing some other thing."
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
finished_code_parse = (parse(clog))
codes_only = finished_code_parse.map{|x|x.values}.flatten.inspect
tot_codes = codes_only.count('/...,/') # keep this
puts "#{tot_codes} This should equal all total counts and need to be removed once done"
#This handels the 400 codes
fourcodes = codes_only.count('/4../')
#This handels the 300 codes
threecodes = codes_only.count('/3../')
#this handels 200 codes
twocodes = codes_only.count('/2../')


class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end
puts "ALL INFO BELOW"


puts "300 count need to be removed once done #{threecodes}"
puts "200 count  need to be removed once done#{twocodes}"
puts "400 count need to be removed once done #{fourcodes}"
fourpercent = fourcodes.percent_of(tot_codes).round
puts " The percent of error request is #{fourpercent}."
threepercent = threecodes.percent_of(tot_codes).round
puts " The percent of redirect request is #{threepercent}."
puts " The most requested file is #{file_name}"



  #Once you download the file, you will be parsing the file in order to answer several questions:
#How many total requests were made in the time period represented in the log? DONE
#How many requests were made on each day? 
#What percentage of the requests were not successful (any 4xx status code)? DONE
#What percentage of the requests were redirected elsewhere (any 3xx codes)? DONE
#What was the most-requested file?
#What was the least-requested file?

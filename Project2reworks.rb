puts "Now downloading file."
require 'open-uri'
open('http_access_log', 'wb') do |file|
  file << open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log').read
end
LOCAL_FILE = 'http_access_log'
totals = {}
files = {}
counts = {}
errors = []
dates = {}
File.foreach(LOCAL_FILE) do |line|

	# Simple split on spaces is good enough here?
	#vals = line.split(" ")

	# Nope. Use Regex
	vals = /.*\[(.*) \-[0-9]{4}\] \"([A-Z]+) (.+?)( HTTP.*\"|\") ([2-5]0[0-9]) .*/.match(line)

	# Sanity check the line -- capture the error and move on
	if !vals then
		errors.push(line)
		next
	end

	# Grab the data from the fields we care about
	req_date = Date.strptime(vals[1], '%d/%b/%Y:%H:%M:%S')
	d_str = req_date.strftime('%Y-%m')
	http_verb = vals[2]
	file_name = vals[3]
	stat_code = vals[5]
	# Add the file name to the hash if not there; increment otherwise
	files[file_name] = (if files[file_name] then files[file_name]+=1 else 1 end)

	# Add the status code to the hash if not there; increment otherwise
	counts[stat_code] = (if counts[stat_code] then counts[stat_code]+=1 else 1 end)

	# Check if we're on a new date; if so, add a new array to the hash
	unless totals[d_str] then totals[d_str] = [] end

	# Add the whole line into the array for that day
	totals[d_str].push(line)
	dates[d_str] = (if dates[d_str] then dates[d_str]+=1 else 1 end)

end
#working with the files
filessort = files.sort_by{|file,request| request}

#This handels the 400 codes
fourcodes = 0
#This handels the 300 codes
threecodes = 0
#thiscounts all codes
counts.each do |code, count|
	if code[0] == "3" then threecodes += count end
	if code[0] == "4" then fourcodes += count end
end
#This findes to lines for the persentage. Their is probaly some way to do this easyier.
bigtotal = 0
counts.each do |code, count|
	if code[0] == "3" then bigtotal += count end
	if code[0] == "4" then bigtotal += count end
	if code[0] == "2" then bigtotal += count end
	if code[0] == "5" then bigtotal += count end
end
#this handels percentage
class Numeric
  def percent_of(a)
    self.to_f / a.to_f * 100.0
  end
end
#this calculates persentages
fourpercent = fourcodes.percent_of(bigtotal).round
threepercent = threecodes.percent_of(bigtotal).round
#all data goes under here
dates.each do |months, lines|
	puts "   the total for this month is #{months}: #{lines}"
end
puts "The least requested file is #{filessort.first}"
puts "the most requested file is #{filessort.last}"
puts "#{fourpercent}% of request ended in an error"
puts "#{threepercent}% of request ended in a redirect"
puts "the total number of request it #{bigtotal}"

  #Once you download the file, you will be parsing the file in order to answer several questions:
#How many total requests were made in the time period represented in the log? DONE
#How many requests were made on each day? 
#What percentage of the requests were not successful (any 4xx status code)? Done
#What percentage of the requests were redirected elsewhere (any 3xx codes)? done
#What was the most-requested file? DOne
#What was the least-requested file? DOne

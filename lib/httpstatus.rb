require "httpstatus/version"
require 'uri'
require 'net/http'

module HttpStatus

  class StatusCheck
    # Check the status
    # example : 
    #  >> statuswebsite = HttpStatus::StatusCheck.new
    #  	>> statuswebsite.Average_Response_Status(websitename, checkingtimeinterval, timeperiod)   
    #   >> Argument : websitename 		= websitename 			: example gitlab.com about.gitlab.com
    #   >> Argument : checkingtimeinterval 	= time interval in seconds 	: example 5
    #   >> Argument : timeperiod	  	= Timeperiod in minutes		: example  10

    def Average_Response_Status(sitename, checkingtimeinterval, timeperiod)
      total_response_time = 0
      checking_round = (timeperiod.to_i * 60) / checkingtimeinterval.to_i
      puts "_" * 70
      puts "Site-Name  " + "             " + "Response-Time" + "  " + "Response-Code" + "" + "Message"
      puts "_" * 70
      1.upto(checking_round) do |i|
        query = sitename
        uri = URI(query)
        start_time = Time.now
        res = Net::HTTP.get_response(uri)
        end_time = Time.now - start_time
        total_response_time = total_response_time + end_time

        # Status
        if res == ""
          puts " No Response, Trying again"
        else
          puts ARGV[1] + "              " + end_time.to_s + "       " + res.code + "         " + res.message
        end

        # Waiting for next try 
        sleep ARGV[2].to_i 
      end
        # Calculate Average response time over the period of time
        average_response_time = total_response_time.round(3) / checking_round
        puts "_" * 70
        puts "Average Resonse time #{average_response_time}"
        puts "-" * 70
    end
  end
end

require 'sinatra'
require 'signalwire'

sales = "+12027621401" # actually a time clock
support = ['+15552233444', '+15552233445']

post '/start' do
  puts params.inspect
  response = Signalwire::Sdk::VoiceResponse.new
  response.say(message: "Thank you for calling SignalWire.") unless params[:retry]
  hour = Time.now.hour

  if hour >= 9 && hour <= 17
    # Office is open
    response.gather(action: '/menu', timeout: 5, num_digits: 1) do |gather|
      gather.say(message: 'Press 1 for sales, or 2 for support.')
    end
  else
    # Office is closed
    response.say(message: "Our offices are currently closed. Please leave a message after the beep.")
    response.record(action: '/record', max_length: 15, beep: true, timeout: 2)
  end

  response.to_s
end

post '/menu' do
  response = Signalwire::Sdk::VoiceResponse.new
  if params[:Digits] == "1"
    # call sales
    response.dial do |dial|
      dial.number(sales)
    end
  elsif params[:Digits] == "2"
    # call support
    response.dial do |dial|
      support.each do |supp|
        dial.number(supp)
      end
    end
  # This is actually not part of the flow, but it demonstrates the recording without being in off hours
  elsif params[:Digits] == "3"
    response.say(message: "Please leave a message after the beep.")
    response.record(action: '/record', max_length: 15, beep: true, timeout: 2)
  else
    # something went wrong
    response.say(message: "Sorry. I did not understand.")
    response.redirect("/start?retry=1")
  end
  response.to_s
end

post '/record' do
  # we should actually do something with it
  puts "Recording is in #{params[:RecordingUrl]} and is #{params[:RecordingDuration]} long"

  response = Signalwire::Sdk::VoiceResponse.new
  response.hangup
  response.to_s
end
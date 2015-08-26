require 'twilio-ruby'
require 'sanitize'


class TwilioController < ApplicationController
  
  def index
    render text: "Dial Me."
  end

  # POST ivr/welcome
  def ivr_welcome
    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: '1', action: menu_path do |g|
        g.Play "http://howtodocs.s3.amazonaws.com/et-phone.mp3", loop: 3
      end
    end
    render text: response.text
  end

  # GET ivr/selection
  def menu_selection
    user_selection = params[:Digits]

    case user_selection
    when "1"
      @output = "To get to your extraction point, get on your bike and go down
        the street. Then Left down an alley. Avoid the police cars. Turn left
        into an unfinished housing development. Fly over the roadblock. Go
        passed the moon. Soon after you will see your mother ship."
      twiml_say(@output, true)
    when "2"
      list_planets
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end

  end

  def list_planets
    message = "To call the planet Broh doe As O G, press 2. To call the planet
    DuhGo bah, press 3. To call an oober asteroid to your location, press 4. To
    go back to the main menu, press the star key."

    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: '1', action: planets_path do |g|
        g.Say message, voice: 'alice', language: 'en-GB', loop:3
      end
    end

    render text: response.text
  end

  # POST/GET ivr/planets
  def planet_selection
    user_selection = params[:Digits]

    case user_selection
    when "2"
      connect_to_extension("Brodo")
    when "3"
      connect_to_extension("Dugobah")
    when "4"
      connect_to_extension("113")
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end
  end

  def connect_to_extension(extension)
    @agent = Agent.find_by(extension: extension)

    response = Twilio::TwiML::Response.new do |r|
      r.Dial action: "/ivr/agent_voicemail?agent_id=#{@agent.id}" do |d|
        d.Number @agent.phone_number, url: "/ivr/screen_call"
      end
    end

    render text: response.text
  end

  # POST ivr/screen_call
  def screen_call
    @customer_phone_number = params[:From]

    response = Twilio::TwiML::Response.new do |r|
      # will return status 'completed' if digits are entered
      r.Gather numDigits: '1', action: '/ivr/agent_screen_response' do |g|
        g.Say "You have an incoming call from an Alien with phone number
        #{@customer_phone_number}."
        g.Say "Press any key to accept."
      end

      # will return status no-answer since this is a Number callback
      r.Say "Sorry, I didn't get your response."
      r.Hangup
    end
    render text: response.text
  end

  # POST ivr/agent_screen_response
  def agent_screen_response
    agent_selected = params[:Digits]

    if agent_selected
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Connecting you to the E.T. in distress. All calls are recorded."
      end
    end

    render text: response.text
  end

  # POST ivr/agent_voicemail
  def agent_voicemail
    status = params[:DialCallStatus] || "completed"
    recording = params[:RecordingUrl]

    # If the call to the agent was not successful, and there is no recording,
    # then record a voicemail
    if (status != "completed" || recording.nil? )
      response = Twilio::TwiML::Response.new do |r|
        r.Say "It appears that planet is unavailable. Please leave a message after the beep.", voice: 'alice', language: 'en-GB'
        r.Record maxLength: '20', transcribe: true, transcribeCallback: "/recordings/create?agent_id=#{params[:agent_id]}"
        r.Say "I did not receive a recording.", voice: 'alice', language: 'en-GB'
      end
    # otherwise end the call
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Hangup
      end
    end
    render text: response.text
  end

  private

  def twiml_say(phrase, exit = false)
    # Respond with some TwiML and say something.
    # Should we hangup or go back to the main menu?
    response = Twilio::TwiML::Response.new do |r|
      r.Say phrase, voice: 'alice', language: 'en-GB'
      if exit 
        r.Say "Thank you for calling the ET Phone Home Service - the
        adventurous alien's first choice in intergalactic travel."
        r.Hangup
      else
        r.Redirect welcome_path
      end
    end

    render text: response.text
  end

  def twiml_dial(phone_number)
    response = Twilio::TwiML::Response.new do |r|
      r.Dial phone_number
    end

    render text: response.text
  end
end
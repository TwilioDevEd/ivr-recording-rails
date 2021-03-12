class TwilioController < ApplicationController
  def index
    render plain: "Dial Me."
  end

  # POST ivr/welcome
  def ivr_welcome
    response = Twilio::TwiML::VoiceResponse.new
    response.gather(num_digits: '1', action: menu_path) do |gather|
      gather.play(url: "https://can-tasty-8188.twil.io/assets/et-phone.mp3", loop: 3)
    end

    render xml: response.to_s
  end

  # GET ivr/selection
  def menu_selection
    user_selection = params[:Digits]

    case user_selection
    when "1"
      output = "To get to your extraction point, get on your bike and go down
        the street. Then Left down an alley. Avoid the police cars. Turn left
        into an unfinished housing development. Fly over the roadblock. Go
        passed the moon. Soon after you will see your mother ship."
      twiml_say(output, true)
    when "2"
      list_planets
    else
      output = "Returning to the main menu."
      twiml_say(output)
    end
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
      output = "Returning to the main menu."
      twiml_say(output)
    end
  end

  # POST ivr/screen_call
  def screen_call
    customer_phone_number = params[:From]

    response = Twilio::TwiML::VoiceResponse.new
    response.gather(num_digits: '1', action: ivr_agent_screen_path) do |gather|
      gather.say(message: "You have an incoming call from an Alien with phone number
      #{customer_phone_number.chars.join(",")}.")
      gather.say("Press any key to accept.")
    end

    # will return status no-answer since this is a Number callback
    response.say(message: "Sorry, I didn't get your response.")
    response.hangup

    render xml: response.to_s
  end

  # POST ivr/agent_screen
  def agent_screen
    agent_selected = params[:Digits]

    if agent_selected
      response = Twilio::TwiML::VoiceResponse.new
      response.say(message: "Connecting you to the E.T. in distress. All calls are recorded.")
    end

    render xml: response.to_s
  end

  # POST ivr/agent_voicemail
  def agent_voicemail
    status = params[:DialCallStatus] || "completed"
    recording = params[:RecordingUrl]

    # If the call to the agent was not successful, or there is no recording,
    # then record a voicemail
    if (status != "completed" || recording.nil? )
      response = Twilio::TwiML::VoiceResponse.new
      response.say(message: "It appears that planet is unavailable. Please leave a message after the beep.",
          voice: 'alice', language: 'en-GB')
      response.record(finish_on_key: "*", transcribe: true, max_length: '20',
          transcribe_callback: "/recordings/create?agent_id=#{params[:agent_id]}")
      response.say(message: "I did not receive a recording.", voice: 'alice', language: 'en-GB')
    # otherwise end the call
    else
      response = Twilio::TwiML::VoiceResponse.new
      response.hangup
    end

    render xml: response.to_s
  end

  private

  def twiml_say(phrase, exit = false)
    # Respond with some TwiML and say something.
    # Should we hangup or go back to the main menu?
    response = Twilio::TwiML::VoiceResponse.new
    response.say(message: phrase, voice: 'alice', language: 'en-GB')
    if exit
      response.say(message: "Thank you for calling the ET Phone Home Service - the
      adventurous alien's first choice in intergalactic travel.")
      response.hangup
    else
      response.redirect(welcome_path)
    end

    render xml: response.to_s
  end

  def twiml_dial(phone_number)
    response = Twilio::TwiML::VoiceResponse.new
    response.dial(phone_number)

    render xml: response.to_s
  end

  def list_planets
    message = "To call the planet Broh doe As O G, press 2. To call the planet
    DuhGo bah, press 3. To call an oober asteroid to your location, press 4. To
    go back to the main menu, press the star key."

    response = Twilio::TwiML::VoiceResponse.new
    response.gather(num_digits: '1', action: planets_path) do |gather|
      gather.say(message: message, voice: 'alice', language: 'en-GB', loop: 3)
    end

    render xml: response.to_s
  end

  def connect_to_extension(extension)
    agent = Agent.find_by(extension: extension)

    response = Twilio::TwiML::VoiceResponse.new
    response.dial(action: ivr_agent_voicemail_path(agent_id: agent.id)) do |dial|
      dial.number(agent.phone_number, url: ivr_screen_call_path)
    end

    render xml: response.to_s
  end
end

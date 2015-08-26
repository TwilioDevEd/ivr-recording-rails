require 'twilio-ruby'

class RecordingsController < ApplicationController

  # GET /recordings/:agent
  def show
    @agent_number = params[:agent] || "4695186234"
    @agent = Agent.find_by(phone_number: @agent_number)
    @recordings = @agent.recordings 
  end

  # POST /recordings/create
  def create
    agent_id = params[:agent_id]
    @agent = Agent.find(agent_id)

    @agent.recordings.create(
      url: params[:RecordingUrl] + ".mp3",
      transcription: params[:TranscriptionText],
      phone_number: params[:Caller]
    )

    render status: :ok, plain: "Ok"
  end

end
class ParticipantsController < ApplicationController
  before_action :set_event, only: [:new, :create, :scramble]
  before_action :set_players, only: :scramble

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.event = @event
    if @participant.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def scramble
    @givers.each do |giver|
      @game[giver] = random_player_for(giver)
    end
    raise
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :email)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_players
    @emails = []
    @event.participants.each do |participant|
      @emails<<participant.email
    end
    @receivers = @emails
    @givers = @emails.dup
    @game = {}
  end

  def random_player_for(giver)
    found = false
    until found do
      receiver = @receivers.sample
      unless receiver == giver
        found = true
        @receivers.delete(receiver)
      end
    end
    receiver
  end
end

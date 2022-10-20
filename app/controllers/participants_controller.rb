class ParticipantsController < ApplicationController
  before_action :set_event, only: [:new, :create, :scramble]

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
    emails = []
    @event.participants.each do |participant|
      emails<<participant.email
    end
    @players = emails
    @santas = emails.dup
    @game = {}
    @santas.each do |santa|
      @game[santa] = random_player_for(santa)
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

  def random_player_for(santa)
    found = false
    until found do
      player = @players.sample
      unless player == santa
        found = true
        @players.delete(player)
      end
    end
    player
  end
end

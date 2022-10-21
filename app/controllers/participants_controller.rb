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
    @emails = []
    @event.participants.each do |participant|
      @emails<<participant.email
    end
    @names = []
    @event.participants.each do |participant|
      @names<<participant.name
    end
    @givers = @emails
    @receivers = @names
    perform(@givers, @receivers)
    SantaMailer.list(@game).deliver_later
  end

  private

  def perform(givers, receivers)
    @game = {}
    givers.each do |giver|
      @game[giver] = random_player_for(giver, receivers)
    end
  end

  def participant_params
    params.require(:participant).permit(:name, :email)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def random_player_for(giver, receivers)
    found = false
    until found do
      receiver = receivers.sample
      unless receiver.include? giver
        found = true
      end
    end
    receiver
  end
end

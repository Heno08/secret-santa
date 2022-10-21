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
    @emails = @event.participants
    @receivers = @emails
    @givers = @emails.dup
    ScrambleJob.perform_now(@givers, @receivers)
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :email)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end

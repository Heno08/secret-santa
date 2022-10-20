class EventsController < ApplicationController
  def new
    @event = Event.new
    @participants = Participant.new
  end

  def create
    raise
  end
end

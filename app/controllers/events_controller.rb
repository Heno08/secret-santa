class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    raise
  end
end

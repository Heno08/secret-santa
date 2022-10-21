class ScrambleJob < ApplicationJob
  queue_as :default

  def perform(event)
    # Do something later
    set_players(event)
    @givers.each do |giver|
      @game[giver] = random_player_for(giver)
    end
    puts "Finished!"
    raise
  end

  private

  def set_players(event)
    @emails = []
    event.participants.each do |participant|
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

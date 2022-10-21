class ScrambleJob < ApplicationJob
  queue_as :default

  def perform(givers, receivers)
    @game = {}
    givers.each do |giver|
      @game[giver] = random_player_for(giver, receivers)
    end
  end

  private

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

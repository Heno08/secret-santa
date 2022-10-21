class SantaMailer < ApplicationMailer
  def list(game)
    game.each do |giver, receiver|
      @greeting = "Your are the Santa for: #{receiver}"
      mail(to: giver, subject: 'You Secret Santa')
    end
  end
end

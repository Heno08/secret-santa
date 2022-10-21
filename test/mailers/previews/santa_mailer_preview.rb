# Preview all emails at http://localhost:3000/rails/mailers/santa_mailer
class SantaMailerPreview < ActionMailer::Preview
  def welcome
    SantaMailer.list('henryjamesblackburn@hotmail.co.uk', 'Sebastien')
  end
end

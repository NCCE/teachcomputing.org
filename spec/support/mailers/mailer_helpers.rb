module MailerHelpers
  def secondary_welcome_text_master
    file = File.open('spec/support/mailers/secondary/welcome_text_master.txt')
    txt = file.read
    file.close
    txt
  end
end

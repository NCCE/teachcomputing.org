module Programmes
  class IBelong < Programme
    PROGRAMME_TITLE = 'I Belong: encouraging girls into computer science'.freeze

    def mailer
      IBelongMailer
    end

    def path
      about_i_belong_path
    end

    def enrol_path(opts = {})
      enrol_i_belong_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def send_pending_mail?
      true
    end
  end
end

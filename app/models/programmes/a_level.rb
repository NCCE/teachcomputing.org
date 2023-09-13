module Programmes
  class ALevel < Programme
    PROGRAMME_TITLE = 'A level subject knowledge'.freeze

    def mailer
      ALevelMailer
    end

    def path
      a_level_path
    end

    def enrol_path(opts = {})
      enrol_a_level_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end
  end
end

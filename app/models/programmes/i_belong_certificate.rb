module Programmes
  class IBelongCertificate < Programme
    PROGRAMME_TITLE = 'I Belong'.freeze

    def path
      i_belong_certificate_path
    end

    def enrol_path(opts = {})
      enrol_i_belong_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end

    def brand_color_name
      'orange'
    end
  end
end

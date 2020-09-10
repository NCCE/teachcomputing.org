class CertificateGenerator
  CSA_PROGRAMME_TITLE = 'GCSE Computer Science Subject Knowledge'.freeze
  PRIMARY_PROGRAMME_TITLE = 'Primary Computing Teaching'.freeze

  def initialize(user:, programme:, transition:)
    @user = user
    @programme = programme
    @transition = transition
  end

  def generate_pdf
    temp_id = SecureRandom.uuid
    temp_path = File.join(Rails.root, 'tmp', "#{temp_id}.pdf")

    user_name = "#{@user.first_name} #{@user.last_name}"
    programme_title = select_programme_title
    date_awarded = @transition.created_at.strftime('%d/%m/%Y')
    cert_number = certificate_number
    slug = @programme.slug
    teacher_ref_no = @user.teacher_reference_number

    Prawn::Document.generate(temp_path) do
      font_families.update('Roboto' => {
                             normal: Rails.root.join('app', 'assets', 'fonts', 'Roboto-Regular.ttf').to_s,
                             bold: Rails.root.join('app', 'assets', 'fonts', 'Roboto-Bold.ttf').to_s
                           })
      font 'Roboto'

      move_down 115
      text user_name, align: :center, size: 18, color: '333448'

      move_down 115
      text programme_title, align: :center, size: 18, color: '333448'

      text_box date_awarded,
               at: [392, 134],
               width: 100,
               height: 24,
               size: 16,
               valign: :bottom,
               style: :bold

      text_box cert_number,
               at: [370, 114],
               width: 120,
               height: 24,
               size: 16,
               valign: :bottom,
               style: :bold

      if slug == 'cs-accelerator' && teacher_ref_no
        text_box 'Teacher Reference Number:',
                 at: [297, 97],
                 width: 150,
                 height: 44,
                 size: 14,
                 valign: :bottom

        text_box teacher_ref_no,
                 at: [360, 76],
                 width: 130,
                 height: 24,
                 size: 16,
                 valign: :bottom,
                 style: :bold,
                 overflow: :shrink_to_fit
      end
    end

    src_pdf = CombinePDF.load(File.join(Rails.root, 'app', 'assets', 'pdf', 'ncce-cert-src.pdf'))
    text_pdf = CombinePDF.load(temp_path).pages[0]
    src_pdf.pages[0] << text_pdf

    src_pdf.save(temp_path)

    filename = "#{programme_title.parameterize}-certificate-#{cert_number}.pdf"

    { path: temp_path, filename: filename }
  end

  private

    def certificate_number
      cert_number = @transition.metadata['certificate_number']
      passed_date = @transition.created_at
      "#{passed_date.strftime('%Y%m')}-#{format('%03d', cert_number || 0)}"
    end

    def select_programme_title
      return CSA_PROGRAMME_TITLE if @programme.slug == 'cs-accelerator'

      PRIMARY_PROGRAMME_TITLE
    end
end

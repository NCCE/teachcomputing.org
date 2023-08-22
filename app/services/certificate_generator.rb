class CertificateGenerator
  def initialize(user:, programme:, transition:, dependencies: {})
    @src_path = dependencies.fetch(:src_path) do
      File.join(Rails.root, 'app', 'webpacker', 'pdf', "#{programme.slug}-src.pdf")
    end

    @output_path = dependencies.fetch(:output_path) do
      File.join(Rails.root, 'tmp', "#{SecureRandom.uuid}.pdf")
    end

    @user = user
    @programme = programme
    @transition = transition
  end

  def generate_pdf
    date_awarded = @transition.created_at.strftime('%d %B %Y')
    cert_number = certificate_number
    name = @programme.certificate_name_for_user(@user)

    Prawn::Document.generate(@output_path, page_size: 'A4') do
      font_families.update('Roboto' => {
                             normal: Rails.root.join('app', 'webpacker', 'fonts', 'Roboto-Regular.ttf').to_s,
                             bold: Rails.root.join('app', 'webpacker', 'fonts', 'Roboto-Bold.ttf').to_s
                           })
      font 'Roboto'

      # stroke_axis at: [200,0], step_length: 10, color: 'FF0000' # ruler for debugging

      move_down 224
      text name, align: :center, size: 18, color: '333448'

      move_down 320
      translate(-36, 0) do
        text_box date_awarded,
                 at: [81, 190],
                 width: 200,
                 align: :center,
                 size: 16,
                 style: :bold

        text_box cert_number,
                 at: [314, 190],
                 width: 200,
                 align: :center,
                 size: 16,
                 style: :bold
      end
    end

    src_pdf = CombinePDF.load(@src_path)
    text_pdf = CombinePDF.load(@output_path).pages[0]
    src_pdf.pages[0] << text_pdf

    src_pdf.save(@output_path)

    filename = "#{@programme.programme_title.parameterize}-certificate-#{cert_number}.pdf"

    { path: @output_path, filename: filename }
  end

  private
    def certificate_number
      cert_number = @transition.metadata['certificate_number']
      passed_date = @transition.created_at
      "#{passed_date.strftime('%Y%m')}-#{format('%03d', cert_number || 0)}"
    end
end

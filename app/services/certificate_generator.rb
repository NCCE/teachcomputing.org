class CertificateGenerator
  def initialize(user:, programme:, transition:, dependencies: {})
    @src_path = dependencies.fetch(:src_path) do
      File.join(Rails.root, 'app', 'assets', 'pdf', "#{programme.slug}-src.pdf")
    end

    @output_path = dependencies.fetch(:output_path) do
      File.join(Rails.root, 'tmp', "#{SecureRandom.uuid}.pdf")
    end

    @user = user
    @programme = programme
    @transition = transition
  end

  def generate_pdf
    user_name = "#{@user.first_name} #{@user.last_name}"
    date_awarded = @transition.created_at.strftime('%d/%m/%Y')
    cert_number = certificate_number
    slug = @programme.slug
    teacher_ref_no = @user.teacher_reference_number

    Prawn::Document.generate(@output_path) do
      font_families.update('Roboto' => {
                             normal: Rails.root.join('app', 'assets', 'fonts', 'Roboto-Regular.ttf').to_s,
                             bold: Rails.root.join('app', 'assets', 'fonts', 'Roboto-Bold.ttf').to_s
                           })
      font 'Roboto'

      move_down 115
      text user_name, align: :center, size: 18, color: '333448'

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

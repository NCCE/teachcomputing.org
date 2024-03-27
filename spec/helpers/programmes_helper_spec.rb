require "rails_helper"

describe ProgrammesHelper, type: :helper do
  describe("#certificate_number") do
    it "defaults to 0 for missing param" do
      expect(certificate_number(nil, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-000")
    end

    it "adds one to index correctly" do
      expect(certificate_number(1, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-001")
    end

    it "pads numbers < 100 correctly" do
      expect(certificate_number(10, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-010")
      expect(certificate_number(99, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-099")
    end

    it "allows numbers > 100 correctly" do
      expect(certificate_number(100, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-100")
      expect(certificate_number(2845, DateTime.parse("2001-02-03T04:05:06+07"))).to eq("200102-2845")
    end
  end

  describe("#to_word_ordinal") do
    it 'returns "0th" when argument is nil' do
      expect(to_word_ordinal(nil)).to eq("0th")
    end

    it 'returns "first" when argument is 1' do
      expect(to_word_ordinal(1)).to eq("first")
    end

    it 'returns "0th" when argument is 0' do
      expect(to_word_ordinal(0)).to eq("0th")
    end

    it 'returns "-10th" when argument is -10' do
      expect(to_word_ordinal(-10)).to eq("-10th")
    end

    it 'returns "tenth" when argument is 10' do
      expect(to_word_ordinal(10)).to eq("tenth")
    end

    it 'returns "third" when argument is 3' do
      expect(to_word_ordinal(3)).to eq("third")
    end

    it 'returns "seventh" when argument is 7' do
      expect(to_word_ordinal(7)).to eq("seventh")
    end
  end

  describe("#index_to_word_ordinal") do
    it 'returns "0th" when argument is -1' do
      expect(index_to_word_ordinal(-1)).to eq("0th")
    end

    it 'returns "first" when argument is nil' do
      expect(index_to_word_ordinal(nil)).to eq("first")
    end

    it 'returns "first" when argument is 0' do
      expect(index_to_word_ordinal(0)).to eq("first")
    end

    it 'returns "-10th" when argument is -11' do
      expect(index_to_word_ordinal(-11)).to eq("-10th")
    end

    it 'returns "tenth" when argument is 9' do
      expect(index_to_word_ordinal(9)).to eq("tenth")
    end

    it 'returns "third" when argument is 2' do
      expect(index_to_word_ordinal(2)).to eq("third")
    end

    it 'returns "seventh" when argument is 6' do
      expect(index_to_word_ordinal(6)).to eq("seventh")
    end
  end

  describe("#display_programme_tag") do
    let(:secondary_programme) { create(:secondary_certificate) }
    let(:primary_programme) { create(:primary_certificate) }
    let(:a_level_programme) { create(:a_level) }
    let(:i_belong) { create(:i_belong) }
    let(:subject_knowledge) { create(:cs_accelerator) }
    it "returns the programmes certificate name when provided with valid slug" do
      expect(display_programme_tag(secondary_programme.slug)).to eq(Programme.secondary_certificate.certificate_name)
      expect(display_programme_tag(primary_programme.slug)).to eq(Programme.primary_certificate.certificate_name)
      expect(display_programme_tag(a_level_programme.slug)).to eq(Programme.a_level.certificate_name)
      expect(display_programme_tag(i_belong.slug)).to eq(Programme.i_belong.certificate_name)
      expect(display_programme_tag(subject_knowledge.slug)).to eq(Programme.cs_accelerator.certificate_name)
    end
  end

  describe "#programme_pathway_card_data" do
    let(:programme) { create(:programme) }
    let!(:legacy_pathway) { create(:pathway, legacy: true, programme:) }
    let!(:pathways) { create_list(:pathway, 2, programme:) }

    it "should return data for the non-legacy pathways" do
      expect(helper.programme_pathway_card_data(programme).map { _1[:title] }).to match_array pathways.map(&:title)
    end

    context "when asked to exclude a particular pathway" do
      it "should not return it" do
        exclude = pathways.first
        pathways.second.update(title: "test test")
        expect(helper.programme_pathway_card_data(programme, exclude:).map { _1[:title] }).to match_array ["test test"]
      end
    end
  end
end

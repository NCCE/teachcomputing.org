require "rails_helper"

RSpec.describe Achiever::Course::Occurrence do
  let(:course_occurrence) { described_class.face_to_face.first }

  describe "accessor methods" do
    before do
      stub_face_to_face_occurrences
    end

    it "provides the required accessor methods" do
      expect(course_occurrence).to respond_to(:activity_code)
      expect(course_occurrence).to respond_to(:activity_title)
      expect(course_occurrence).to respond_to(:address_venue_name)
      expect(course_occurrence).to respond_to(:address_venue_code)
      expect(course_occurrence).to respond_to(:address_town)
      expect(course_occurrence).to respond_to(:address_postcode)
      expect(course_occurrence).to respond_to(:address_line_one)
      expect(course_occurrence).to respond_to(:age_groups)
      expect(course_occurrence).to respond_to(:booking_url)
      expect(course_occurrence).to respond_to(:course_template_no)
      expect(course_occurrence).to respond_to(:course_occurrence_no)
      expect(course_occurrence).to respond_to(:end_date)
      expect(course_occurrence).to respond_to(:online_cpd)
      expect(course_occurrence).to respond_to(:remote_delivered_cpd)
      expect(course_occurrence).to respond_to(:region)
      expect(course_occurrence).to respond_to(:subject)
      expect(course_occurrence).to respond_to(:start_date)
      expect(course_occurrence).to respond_to(:hub_id)
      expect(course_occurrence).to respond_to(:hub_name)
    end
  end

  describe "constants" do
    describe "FACE_TO_FACE_RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Occurrence::FACE_TO_FACE_RESOURCE_PATH).not_to eq nil
      end
    end

    describe "ONLINE_RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Occurrence::ONLINE_RESOURCE_PATH).not_to eq nil
      end
    end

    describe "QUERY_STRINGS" do
      it "contains page" do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:Page)
      end

      it "contains record count" do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:RecordCount)
      end

      it "contains end date" do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:EndDate)
      end
    end

    describe ".face_to_face" do
      before do
        stub_face_to_face_occurrences
      end

      it "returns an array" do
        expect(described_class.face_to_face).to be_an Array
      end

      it "the array contains Achiever::Course::Occurrence objects" do
        expect(described_class.face_to_face.sample).to be_an described_class
      end
    end

    describe ".online" do
      before do
        stub_online_occurrences
      end

      it "returns an array" do
        expect(described_class.online).to be_an Array
      end

      it "the array contains Achiever::Course::Occurrence objects" do
        expect(described_class.online.sample).to be_an described_class
      end
    end
  end

  describe "@remote_delivered_cpd" do
    before do
      stub_face_to_face_occurrences
    end

    it "is set to true if the API sets it so" do
      expect(described_class.face_to_face.select { |o| o.remote_delivered_cpd }.size).to eq(203)
    end
  end

  describe ".from_resource" do
    let(:resource_hash) do
      {
        "Activity.COURSEOCCURRENCENO": "courseoccurrenceno",
        "Activity.ActivityTitle": "Activity title",
        "Activity.InstanceCode": "INST01",
        "Activity.StartDate": "17/12/2018 10:00:00",
        "Activity.EndDate": "14/01/2019 16:00:00",
        "Activity.OnlineCPD": "true",
        "Activity.RemoteDeliveredCPD": "False",
        "Activity.BookingURL": "www.online.com",
        "Activity.AgeGroups": "000000000;111111111",
        "Activity.SubDelivererID": "subdelivererid",
        "Activity.SubDeliverer": "Subdeliverer name",
        "Activity.Region": "Region",
        "ActivityVenueAddress.VenueCode": "VCODE",
        "ActivityVenueAddress.PostCode": "AB11 1BB",
        "ActivityVenueAddress.City": "City name",
        "ActivityVenueAddress.Address.Line1": "123 Fake Street",
        "ActivityVenueAddress.VenueName": "Venue name",
        "ActivityVenueAddress.Latitude": "",
        "ActivityVenueAddress.Longitude": "",
        "Template.COURSETEMPLATENO": "coursetemplateno",
        "Template.Subject": "1234567"
      }
    end

    it "converts resource json to instance" do
      parsed_json = JSON.parse(resource_hash.to_json, object_class: OpenStruct)
      occurrence = described_class.from_resource(parsed_json)
      expect(occurrence.activity_code).to eq("INST01")
      expect(occurrence.activity_title).to eq("Activity title")
      expect(occurrence.address_venue_name).to eq("Venue name")
      expect(occurrence.address_venue_code).to eq("VCODE")
      expect(occurrence.address_town).to eq("City name")
      expect(occurrence.address_postcode).to eq("AB11 1BB")
      expect(occurrence.address_line_one).to eq("123 Fake Street")
      expect(occurrence.age_groups).to eq(%w[000000000 111111111])
      expect(occurrence.booking_url).to eq("www.online.com")
      expect(occurrence.course_template_no).to eq("coursetemplateno")
      expect(occurrence.course_occurrence_no).to eq("courseoccurrenceno")
      expect(occurrence.end_date).to eq("14/01/2019 16:00:00")
      expect(occurrence.region).to eq("Region")
      expect(occurrence.subject).to eq("1234567")
      expect(occurrence.start_date).to eq("17/12/2018 10:00:00")
      expect(occurrence.hub_id).to eq("subdelivererid")
      expect(occurrence.hub_name).to eq(resource_hash[:"Activity.SubDeliverer"])
      expect(occurrence.remote_delivered_cpd).to eq(false)
      expect(occurrence.online_cpd).to eq(true)
      expect(occurrence.coordinates).to eq(nil)
      expect(occurrence.distance).to eq(nil)
    end

    context "when latitude and longitude are present" do
      before do
        resource_hash[:"ActivityVenueAddress.Latitude"] = "53.38297"
        resource_hash[:"ActivityVenueAddress.Longitude"] = "-1.4659"
      end

      it "adds coordinate property" do
        parsed_json = JSON.parse(resource_hash.to_json, object_class: OpenStruct)
        occurrence = described_class.from_resource(parsed_json)
        expect(occurrence.coordinates).to eq(["53.38297", "-1.4659"])
      end

      it "adds a distance property rounded to 1 decimal place when comparison_coords are passed" do
        allow(Geocoder::Calculations).to receive(:distance_between).and_return(123.45)
        coords = [53.4083714, -2.9915726]
        parsed_json = JSON.parse(resource_hash.to_json, object_class: OpenStruct)
        occurrence = described_class.from_resource(parsed_json, comparison_coords: coords)
        expect(Geocoder::Calculations)
          .to have_received(:distance_between).with(coords, ["53.38297", "-1.4659"])
        expect(occurrence.distance).to eq(123.5)
      end
    end
  end
end

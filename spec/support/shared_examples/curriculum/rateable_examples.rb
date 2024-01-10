require "spec_helper"

RSpec.shared_examples_for "rateable" do |path, comment_path, choices_path, _context, id, rating_id|
  let(:user) { create(:user) }

  describe "POST #rate" do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it "errors for an invalid polarity" do
      expect { post send(path, polarity: :bad, id: :an_id, user_id: user.id) }
        .to raise_error(ArgumentError, "Unexpected polarity: bad")
    end

    it "adds a rating and returns the id" do
      stub_a_rating_request(rating_id)
      post send(path, polarity: :negative, id: id, user_id: "94c52a7c-5001-45e3-82bd-949a882f5fb6")
      body = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(:ok)
      expect(body.origin).to eq("rate")
      expect(body.rating_id).to eq(rating_id)
    end

    it "creates cookies with the expected ids" do
      stub_a_valid_request({data: {add_negative_unit_rating: {}, add_negative_lesson_rating: {}}}.to_json)

      post send(path, polarity: :negative, id: :an_id, user_id: user.id)
      post send(path, polarity: :negative, id: :another_id, user_id: user.id)

      cookie_jar = ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
      expect(cookie_jar.encrypted[:ratings]).to eq(%i[an_id another_id].to_json)
    end

    it "prevents re-rating" do
      stub_a_valid_request({data: {add_negative_unit_rating: {}, add_negative_lesson_rating: {}}}.to_json)

      post send(path, polarity: :negative, id: :an_id, user_id: user.id) # First request
      post send(path, polarity: :negative, id: :an_id, user_id: user.id) # Second request
      body = JSON.parse(response.body)
      expect(response).to have_http_status(:conflict)
      expect(body["data"]).to be_nil
    end
  end

  describe "GET #comment" do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it "adds a comment to a rating" do
      stub_a_valid_request({data: {update_rating: {}}}.to_json)
      post send(comment_path, rating_id: rating_id, comment: "This is a test")
      expect(response).to have_http_status(:ok)
    end

    it "allows comments with double quotes to be escaped and submitted" do
      stub_a_valid_request({data: {update_rating: {}}}.to_json)
      post send(comment_path, rating_id: rating_id, comment: '"<body style="background-color:powderblue;">')
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #choices" do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it "adds a choices to a rating" do
      stub_a_valid_request({data: {update_rating: {}}}.to_json)
      post send(choices_path, rating_id: rating_id, choices: "['first choice','second choice','third choice']")
      expect(response).to have_http_status(:ok)
    end
  end
end

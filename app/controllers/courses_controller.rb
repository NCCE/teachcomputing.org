class CoursesController < ApplicationController
  layout "full-width"
  after_action :discourage_caching, only: :show

  def index
    assign_params
    render :index
  end

  def filter
    assign_params
    if ActiveModel::Type::Boolean.new.cast(params[:js_enabled])
      render json: {
        results: render_to_string("courses/_courses-list", layout: false),
        geocoded_location: @course_filter.search_location_formatted_address,
        location_search: @course_filter.location_search?,
        geocoded_successfully: @course_filter.geocoded_successfully?
      }
    else
      render :index
    end
  end

  def assign_params
    @filter_params = filter_params
    @course_filter = Achiever::CourseFilter.new(
      filter_params:
    )
  end

  def show
    @age_groups = Achiever::Course::AgeGroup.all
    @course = Achiever::Course::Template.find_by_activity_code(params[:id])
    @subjects = Achiever::Course::Subject.all

    return redirect_to course_path(id: @course.activity_code, name: @course.title.parameterize) if params[:name].nil?

    online = @course.online_cpd

    @occurrences = @course.with_occurrences
    assign_start_date if online

    @other_courses = Achiever::Course::Template.without(@course)
    course_programmes

    @booking = online ? ::OnlineBookingPresenter.new : ::LiveBookingPresenter.new

    # Get the user's course attempts
    user_course_info = Achiever::Course::Delegate.find_by_achiever_contact_number(current_user&.stem_achiever_contact_no)
    user_course_info = user_course_info.select { |course| %w[enrolled attended].include?(course.attendance_status) }

    # Grab the one for the current course
    @user_occurrence = user_course_info&.find { |user_occurrence| user_occurrence.course_template_no == @course.course_template_no }

    render :show
  end

  private

  def course_programmes
    @activity = Activity.find_by(stem_course_template_no: @course.course_template_no)
    @programmes = @activity.programmes.enrollable if @activity
  end

  def filter_params
    params.permit(:certificate, :level, :location, :topic, :hub_id, :js_enabled, :radius, course_format: [])
  end

  def assign_start_date
    if @occurrences.any?
      @start_date = start_date(@occurrences)
      @started = (@start_date <= Time.zone.today)
    else # This shouldn't happen but some test data has no occurrences
      Sentry.capture_message("Attempted to determine start date of a course with no occurrences", extra: {course_template_no: @course&.course_template_no})
      @start_date = Date.new(3001, 1, 1)
      @started = false
    end
  end

  # @param occurrences [Array<Achiever::Course::Occurrence>]
  # @return [Date]
  def start_date(occurrences)
    occurrences.collect { |occurrence| occurrence.start_date.to_date }.sort.first
  end
end

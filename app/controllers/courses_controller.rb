class CoursesController < ApplicationController
  layout 'full-width'

  def index
    assign_params
    render :index
  end

  def filter
    assign_params
    if ActiveModel::Type::Boolean.new.cast(params[:js_enabled])
      render json: {
        results: render_to_string('courses/_courses-list', layout: false),
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
      filter_params: filter_params
    )
  end

  def show
    @age_groups = Achiever::Course::AgeGroup.all
    @course = Achiever::Course::Template.find_by_activity_code(params[:id])

    return redirect_to course_path(id: @course.activity_code, name: @course.title.parameterize) if params[:name].nil?

    @occurrences = @course.with_occurrences
    @other_courses = Achiever::Course::Template.without(@course)
    course_programmes

    @booking = @course.online_cpd ? ::OnlineBookingPresenter.new : ::StemBookingPresenter.new

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
end

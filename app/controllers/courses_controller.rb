class CoursesController < ApplicationController
  layout 'full-width'

  def index
    @course_filter = Achiever::CourseFilter.new(
      filter_params: filter_params
    )

    render :index
  end

  def show
    @age_groups = Achiever::Course::AgeGroup.all
    @course = Achiever::Course::Template.find_by_activity_code(params[:id])

    return redirect_to course_path(id: @course.activity_code, name: @course.title.parameterize) if params[:name].nil?

    @occurrences = @course.with_occurrences
    @other_courses = Achiever::Course::Template.without(@course)
    course_programmes

    render :show
  end

  private

    def course_programmes
      @activity = Activity.find_by(stem_course_template_no: @course.course_template_no)
      @programmes = @activity.programmes.enrollable if @activity
    end

    def filter_params
      params.permit(:certificate, :level, :location, :topic, :hub_id)
    end
end

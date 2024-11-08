# frozen_string_literal: true

class CmsEmailCourseListComponent < ViewComponent::Base
  erb_template <<~ERB
    <table>
      <% if @section_title %>
        <tr><td><h2><%= @section_title %></h2></td></tr>
      <% end %>
      <% @courses.each do |course| %>
        <tr>
          <td>
            <%= link_to display_name(course), course_link(course) %>
          </td>
        </tr>
      <% end %>
    </table>
  ERB

  def initialize(courses:, section_title:)
    @courses = courses
    @section_title = section_title
  end

  def display_name(course)
    course.display_name.presence || course.activity.title
  end

  def course_link(course)
    course_url(id: course.activity.stem_activity_code, name: course.activity.title.parameterize)
  end
end

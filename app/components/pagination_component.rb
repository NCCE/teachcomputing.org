# frozen_string_literal: true

class PaginationComponent < ViewComponent::Base
  def initialize(current_page:, page_count:)
    @current_page = current_page
    @page_count = page_count

    @show_previous = @current_page != 1
    @show_next = @current_page != @page_count
    @show_first_dots = @current_page > 3
    @show_last_dots = @current_page < @page_count - 2

    @page_numbers = if @page_count == 1
      []
    else
      [@current_page - 1, @current_page, @current_page + 1].filter { |x| x > 1 && x < @page_count }
    end
  end

  def page_url(page_number)
    request.params.merge(page: page_number)
  end

  def page_link(page_number)
    classes = ["govuk-pagination__item"]
    classes << "govuk-pagination__item--current" if page_number == @current_page
    aria = {label: "Page #{page_number}"}
    aria[:current] = "page" if page_number == @current_page
    content_tag(:li, class: classes) do
      link_to(page_number, page_url(page_number),
        class: ["govuk-link", "govuk-pagination__link"],
        aria:)
    end
  end

  def dots
    content_tag(:li, "&ctdot;".html_safe, class: ["govuk-pagination__item", "govuk-pagination__item--ellipses"])
  end
end

require "rails_helper"
require "axe/rspec"

RSpec.describe("Site search", type: :system, js: true) do
  before do
    resize_window_to_desktop
    stub_featured_posts
    visit root_path
  end

  it "let me make a search in the search bar" do
    when_i_visit_the_home_page
    then_i_should_see_the_search_bar
  end

  it "should let me make a search and see the results" do
    given_there_are_results_similar_to("category theory")
    when_i_visit_the_home_page
    when_i_make_a_search_for("category theory")
    then_i_should_see_n_results(2)
  end

  it "should let me paginate on large quantities of results" do
    given_there_are_many_results_for_the_term("category theory")
    when_i_visit_the_home_page
    when_i_make_a_search_for("category theory")
    then_i_should_be_able_to_paginate_to_the_next_page

    when_i_paginate_to_the_next_page
    then_i_should_be_able_to_paginate_to_the_previous_page
  end

  def given_there_are_results_similar_to(term)
    create(:searchable_pages_ghost_post, title: term, excerpt: "")
    create(:searchable_pages_ghost_post, title: "asdf", excerpt: term)
    create(:searchable_pages_ghost_post, title: "unrelated", excerpt: "unrelated")
  end

  def given_there_are_many_results_for_the_term(term)
    create_list(:searchable_pages_ghost_post, 56, title: term, excerpt: "asdfasdf")
  end

  def when_i_visit_the_home_page
    visit root_path
  end

  def when_i_make_a_search_for(term)
    page
      .find(:css, "nav .site-search-component input")
      .fill_in(with: term)

    page
      .find(:css, "nav .site-search-component button")
      .click
  end

  def when_i_paginate_to_the_next_page
    page.find(:css, ".icon-arrow-left.search__paging")
      .click
  end

  def then_i_should_see_the_search_bar
    expect(page).to have_css("nav .site-search-component")
  end

  def then_i_should_see_n_results(n)
    expect(page).to have_css(".search__results", text: "#{n} results")
  end

  def then_i_should_be_able_to_paginate_to_the_next_page
    expect(page).to have_css(".icon-arrow-left.search__paging")
  end

  def then_i_should_be_able_to_paginate_to_the_previous_page
    expect(page).to have_css(".icon-arrow-right.search__paging")
  end
end

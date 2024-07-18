require "rails_helper"

RSpec.describe PaginationComponent, type: :component do
  context "with one page" do
    before do
      with_request_url "/search?q=test" do
        render_inline(PaginationComponent.new(current_page: 1, page_count: 1))
      end
    end

    it "should only render one page item" do
      expect(page).to have_css(".govuk-pagination__item", count: 1)
      expect(page).to have_css(".govuk-pagination__item--current", count: 1)
    end

    it "should add page param to link" do
      expect(page).to have_link("1", href: %r{page=1})
    end
  end

  context "with two pages" do
    before do
      with_request_url "/search?q=test" do
        render_inline(PaginationComponent.new(current_page: 1, page_count: 2))
      end
    end

    it "should render two page items" do
      expect(page).to have_css(".govuk-pagination__item", count: 2)
    end

    it "should only have one current" do
      expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "1")
    end

    it "should add page param to link" do
      expect(page).to have_link("2", href: %r{page=2})
    end
  end

  context "with lots of pages" do
    context "on first page" do
      before do
        with_request_url "/search?q=test" do
          render_inline(PaginationComponent.new(current_page: 1, page_count: 20))
        end
      end

      it "should render correct number of items" do
        # start, end, 1 middle numbers + 1 sets of dots = 4
        expect(page).to have_css(".govuk-pagination__item", count: 4)
      end

      it "current should be page 1" do
        expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "1")
      end

      it "should render next option" do
        expect(page).to have_css(".govuk-pagination__next")
      end

      it "should not render previous option" do
        expect(page).not_to have_css(".govuk-pagination__prev")
      end
    end

    context "on third page" do
      before do
        with_request_url "/search?q=test&page=3" do
          render_inline(PaginationComponent.new(current_page: 3, page_count: 20))
        end
      end

      it "should render correct number of items" do
        # start, end, 3 middle numbers + 1 sets of dots = 6
        expect(page).to have_css(".govuk-pagination__item", count: 6)
      end

      it "current should be page 1" do
        expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "3")
      end

      it "should render next option" do
        expect(page).to have_css(".govuk-pagination__next")
      end

      it "should render previous option" do
        expect(page).to have_css(".govuk-pagination__prev")
      end
    end

    context "on middleish page" do
      before do
        with_request_url "/search?q=test&page=11" do
          render_inline(PaginationComponent.new(current_page: 11, page_count: 20))
        end
      end

      it "should update page param in any page link" do
        expect(page).to have_link("12", href: %r{page=12})
      end

      it "should render previous option" do
        expect(page).to have_css(".govuk-pagination__prev")
      end

      it "should render next option" do
        expect(page).to have_css(".govuk-pagination__next")
      end

      it "should render correct number of items" do
        # start, end, 3 middle numbers + 2 sets of dots = 7
        expect(page).to have_css(".govuk-pagination__item", count: 7)
      end

      it "current should be page 11" do
        expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "11")
      end
    end

    context "on third from last page" do
      before do
        with_request_url "/search?q=test&page=18" do
          render_inline(PaginationComponent.new(current_page: 18, page_count: 20))
        end
      end

      it "should render correct number of items" do
        # start, end, 3 middle numbers + 1 sets of dots = 6
        expect(page).to have_css(".govuk-pagination__item", count: 6)
      end

      it "current should be page 1" do
        expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "18")
      end

      it "should render next option" do
        expect(page).to have_css(".govuk-pagination__next")
      end

      it "should render previous option" do
        expect(page).to have_css(".govuk-pagination__prev")
      end
    end

    context "on last page" do
      before do
        with_request_url "/search?q=test&page=20" do
          render_inline(PaginationComponent.new(current_page: 20, page_count: 20))
        end
      end

      it "should render previous option" do
        expect(page).to have_css(".govuk-pagination__prev")
      end

      it "should not render next option" do
        expect(page).not_to have_css(".govuk-pagination__next")
      end

      it "should render correct number of items" do
        # start, end, 1 middle numbers + 1 sets of dots = 4
        expect(page).to have_css(".govuk-pagination__item", count: 4)
      end

      it "current should be page 20" do
        expect(page).to have_css(".govuk-pagination__item--current", count: 1, text: "20")
      end
    end
  end
end

// Register every Stimulus controller explicitly. Identifiers must match the
// data-controller attributes in the views, so add new controllers here.

import { Application } from '@hotwired/stimulus'

import CommunityActivityListController from "controllers/community_activity_list_controller"
import CourseFilterController from "controllers/course_filter_controller"
import ExpanderController from "controllers/expander_controller"
import FlatpickrController from "controllers/flatpickr_controller"
import ModalController from "controllers/modal_controller"
import RatingController from "controllers/rating_controller"
import SearchOrderController from "controllers/search_order_controller"
import ToggleAttributeController from "controllers/toggle_attribute_controller"

// ViewComponent controllers
import CmsCommunityActivityGridComponentController from "controllers/components/cms/community_activity_grid_component_controller"
import CmsEnrichmentListComponentController from "controllers/components/cms/enrichment_list_component_controller"
import CommunityEvidenceSubmissionModalComponentController from "controllers/components/community_evidence_submission_modal_component_controller"
import PrimaryDashboardCommunityActivityComponentController from "controllers/components/primary_dashboard_community_activity_component_controller"
import ProgressComponentController from "controllers/components/progress_component_controller"
import SiteSearchComponentController from "controllers/components/site_search_component_controller"

const application = Application.start()

application.register("community-activity-list", CommunityActivityListController)
application.register("course-filter", CourseFilterController)
application.register("expander", ExpanderController)
application.register("flatpickr", FlatpickrController)
application.register("modal", ModalController)
application.register("rating", RatingController)
application.register("search-order", SearchOrderController)
application.register("toggle-attribute", ToggleAttributeController)

application.register("cms--community-activity-grid-component", CmsCommunityActivityGridComponentController)
application.register("cms--enrichment-list-component", CmsEnrichmentListComponentController)
application.register("community-evidence-submission-modal-component", CommunityEvidenceSubmissionModalComponentController)
application.register("primary-dashboard-community-activity-component", PrimaryDashboardCommunityActivityComponentController)
application.register("progress-component", ProgressComponentController)
application.register("site-search-component", SiteSearchComponentController)

// Support defining methods to be called on pageshow and pagehide events
window.addEventListener('pageshow', event => {
  application.controllers.forEach(controller => {
    if (typeof controller.pageShow === 'function') {
      controller.pageShow(event.persisted)
    }
  })
})
window.addEventListener('pagehide', () => {
  application.controllers.forEach(controller => {
    if (typeof controller.pageHide === 'function') {
      controller.pageHide()
    }
  })
})

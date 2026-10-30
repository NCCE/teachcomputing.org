import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

import AchievementListFieldController from "administrate/controllers/achievement_list_field_controller"

const application = Application.start()

application.register("achievement-list-field--achievement-list-field", AchievementListFieldController)

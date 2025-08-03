import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import "@hotwired/turbo-rails"
import "controllers"

import Rails from "@rails/ujs"
Rails.start()

export { application }

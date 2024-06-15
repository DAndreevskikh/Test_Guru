require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import 'bootstrap'

import * as bootstrap from 'bootstrap';
window.bootstrap = bootstrap;
console.log(bootstrap);
import $ from 'jquery'
window.jQuery = $;
window.$ = $;
import "../stylesheets/application"

import { createPopper } from '@popperjs/core';
window.Popper = createPopper;

import "../utilities/sorting.js"
import "../utilities/password_confirmation.js"
import "../utilities/form_inline.js"
import "../utilities/progress_bar.js"
import "../packs/feedback_modal.js"
import "../packs/badge_form.js"
import "../packs/timer.js"

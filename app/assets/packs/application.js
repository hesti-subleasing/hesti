import 'bootstrap'
import '../stylesheets/application.scss'

require.context("../images", true);
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
// require("channels")
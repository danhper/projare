import riot from 'riot'

import {userService} from 'services'

riot.mixin('login-required', {
  init: function () {
    if (!userService.isLoggedIn()) {
      riot.route('/')
    }
  }
})

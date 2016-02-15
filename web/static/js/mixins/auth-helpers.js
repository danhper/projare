import riot from 'riot'
import {userService} from 'services'

const helpers = {
  isLoggedIn: userService.isLoggedIn.bind(userService),
  currentUser: () => userService.currentUser
}

riot.mixin('auth-helpers', helpers)

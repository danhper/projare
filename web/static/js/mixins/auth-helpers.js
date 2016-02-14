import riot from 'riot'
import {userService} from 'services'

const helpers = {
  isLoggedIn: userService.isLoggedIn.bind(userService),
}

Object.defineProperty(helpers, 'currentUser', {
  get: () => userService.currentUser
})

riot.mixin('auth-helpers', helpers)

import riot from 'riot'

import {userService} from 'services'

import './app-header.styl'

riot.tag('app-header', require('./app-header.jade')(), function (opts) {
  this.userService = userService

  this.login = () => {
    this.tags.loginModal.open()
  }

  this.onLogin = () => {
    this.tags.loginModal.close()
    this.update()
  }

  this.logout = () => {
    userService.logout()
  }
})

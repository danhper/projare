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

  this.searchProject = (e) => {
    const keyword = this.search.value
    if (keyword) {
      riot.route(`/projects/search?q=${keyword}`)
    } else {
      riot.route('')
    }
    this.search.blur()
  }

  this.on('update', () => {
    this.search.value = riot.route.query().q || ''
  })
})

import riot from 'riot'

import {userService, facebookService} from 'services'
import {notificationManager} from 'utils'

import './users-login.styl'

riot.tag('users-login', require('./users-login.jade')(), function (opts) {
  this.mixin('form', 'loading')

  this.currentMode = 'login'
  this.changeMode = (e) => {
    if (this.currentMode === 'login') {
      this.currentMode = 'signup'
    } else {
      this.currentMode = 'login'
    }
    this.errors = {}
  }

  this.texts = {
    signup: {
      label: 'Sign up',
      link: 'Click here to login'
    },
    login: {
      label: 'Login',
      link: 'Click here to sign up'
    }
  }

  const completeLogin = (user) => {
    notificationManager.notify(`Your are now logged in as ${user.name}`)
    opts.onLogin && opts.onLogin(user)
  }

  this.handleFacebookLogin = () => {
    this.startLoading()
    facebookService.login()
      .then(completeLogin)
      .catch(() => notificationManager.notify('Could not login with Facebook', 'danger'))
      .finally(() => this.endLoading({update: true}))
  }

  this.processForm = () => {
    this.startLoading()
    const user = this.fetchValues('name', 'email', 'password')
    this.errors = {}
    userService[this.currentMode](user)
      .then(completeLogin)
      .catch(e => this.errors = this.formatErrors(e))
      .finally(() => this.endLoading({update: true}))
  }
})

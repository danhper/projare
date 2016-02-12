import riot from 'riot'

import {userService} from 'services'

riot.tag('users-login', require('./users-login.jade')(), function (opts) {
  this.mixin('form')

  this.currentMode = 'login'
  this.changeMode = () => {
    if (this.currentMode === 'login') {
      this.currentMode = 'signup'
    } else {
      this.currentMode = 'login'
    }
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

  this.processForm = () => {
    const user = this.fetchValues('name', 'email', 'password')
    this.errors = {}
    userService.signup(user)
      .then((user) => opts.onLogin && opts.onLogin(user))
      .catch(e => this.errors = this.formatErrors(e))
      .finally(() => this.update())
  }
})

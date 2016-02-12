import riot from 'riot'

riot.tag('users-login', require('./users-login.jade')(), function (opts) {
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
})

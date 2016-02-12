import riot from 'riot'

riot.tag('projects-new', require('./new.jade')(), function (opts) {
  this.mixin('login-required')
})

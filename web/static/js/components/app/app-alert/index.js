import riot from 'riot'

import {notificationManager} from 'utils'

import './alert.styl'

riot.tag('app-alert', require('./alert.jade')(), function (opts) {
  let timeout = null

  this.close = () => {
    this.message = null
    timeout = null
    this.update()
  }

  notificationManager.on('notification', (message, type, options) => {
    if (timeout) {
      clearTimeout(timeout)
    }
    this.message = message
    this.type = type
    this.options = options
    this.update()
    if (options.timeout > 0) {
      timeout = setTimeout(this.close, options.timeout * 1000)
    }
  })
})

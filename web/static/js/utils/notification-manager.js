import riot from 'riot'

const notificationManager = {}

riot.observable(notificationManager)

notificationManager.notify = function (message, type, options) {
  type = type || 'success'
  options = options || {}
  options.timeout = options.timeout || 10
  this.trigger('notification', message, type, options)
}

export default notificationManager

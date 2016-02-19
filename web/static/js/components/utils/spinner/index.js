import riot from 'riot'

import './spinner.styl'

riot.tag('spinner', require('./spinner.html'), function (opts) {
  this.size = opts.size || 60
  this.halfSize = Math.floor(this.size / 2)
  this.radiusSize = Math.floor(this.size / 10)
  this.color = opts.color || '#1D365D'
})

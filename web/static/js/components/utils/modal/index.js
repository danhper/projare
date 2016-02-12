import riot from 'riot'

import './modal.styl'

riot.tag('utils-modal', require('./modal.jade')(), function (opts) {
  this.open = () => {
    $(this.root).find('.modal').modal()
  }
})

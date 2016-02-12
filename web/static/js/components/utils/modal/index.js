import riot from 'riot'

import './modal.styl'

riot.tag('utils-modal', require('./modal.jade')(), function (opts) {
  this.on('mount', () => {
    this.modal = $(this.root).find('.modal')
  })

  this.open = () => {
    this.modal.modal()
  }

  this.close = () => {
    this.modal.modal('hide')
  }
})

import riot from 'riot'
import autosize from 'autosize'

import './form-row.styl'

riot.tag('form-row', require('./form-row.jade')(), function (opts) {
  this.on('mount', () => {
    if (opts.type === 'textarea') {
      autosize(this.root.querySelector('textarea'))
    }
    const input = this.root.querySelector('.input')
    input.addEventListener('keyup', () => this.trigger('change', opts.field))
    input.addEventListener('change', () => this.trigger('change', opts.field))
  })

  this.inputValue = (field) => {
    const elem = this.root.querySelector(`[name="${field}"]`)
    return elem && elem.value
  }
})

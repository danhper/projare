import riot from 'riot'
import autosize from 'autosize'

import './form-row.styl'

riot.tag('form-row', require('./form-row.jade')(), function (opts) {
  this.on('mount', () => {
    const input = this.root.querySelector('.input')
    input.addEventListener('keyup', () => this.trigger('change', opts.field))
    input.addEventListener('change', () => this.trigger('change', opts.field))
    if (opts.type === 'textarea') {
      this.textarea = this.root.querySelector('textarea')
      autosize(this.textarea)
    }
  })

  this.on('updated', () => {
    if (opts.type === 'textarea' && this.textarea) {
      const evt = document.createEvent('Event')
      evt.initEvent('autosize:update', true, false)
      this.textarea.dispatchEvent(evt)
    }
    if (opts.type === 'select') {
      // $(this.root.querySelector('select')).dropdown({optionClass: 'withripple'})
    }
  })

  this.inputValue = (field) => {
    const elem = this.root.querySelector(`[name="${field}"]`)
    return elem && elem.value
  }
})

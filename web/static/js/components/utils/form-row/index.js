import riot from 'riot'
import autosize from 'autosize'

riot.tag('form-row', require('./form-row.jade')(), function (opts) {
  this.on('mount', () => {
    if (opts.type === 'textarea') {
      autosize(this.root.querySelector('textarea'))
    }
  })

  this.inputValue = (field) => {
    const elem = this.root.querySelector(`[name="${field}"]`)
    return elem && elem.value
  }
})

import riot from 'riot'

import escape from 'lodash.escape'

riot.tag('formatted-text', '', function (opts) {
  this.on('update', () => {
    opts.text = escape(opts.text || '')
    this.root.innerHTML = opts.text.replace(/\n/g, '<br>')
    this.update()
  })
})

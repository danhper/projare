import riot from 'riot'

import escape from 'lodash.escape'

riot.tag('formatted-text', '', function (opts) {
  this.on('update', () => {
    if (!opts.content) {
      return
    }
    let text = opts.key ? opts.content[opts.key] : opts.content
    text = escape(text || '')
    this.root.innerHTML = text.replace(/\n/g, '<br>')
    this.update()
  })
})

import riot from 'riot'
import marked from 'marked'
import truncate from 'html-truncate'

import './markdown.styl'

riot.tag('markdown', '', function (opts) {
  this.on('update', () => {
    if (!opts.content) {
      return
    }
    const content = opts.key ? opts.content[opts.key] : opts.content
    let html = marked(content || '', {gfm: true})
    if (opts.limit) {
      html = truncate(html, opts.limit, { keepImageTag: true })
    }
    this.root.innerHTML = html
  })
})

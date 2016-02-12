import riot from 'riot'
import {mountTag} from 'utils'

import './app-body.styl'

riot.tag('app-body', '', '', 'class="container"', function (opts) {
  riot.route('', () => {
    mountTag(this.root, 'event-list')
  })
  riot.route('/*', (name) => {
    console.log('ROUTE', name)
  })
})

import riot from 'riot'

import './app-body.styl'

riot.tag('app-body', '', '', 'class="container"', function (opts) {
  riot.route('', () => {
    riot.mount(this.root, 'event-list')
  })
  riot.route('/*', (name) => {
    console.log('ROUTE', name)
  })
})

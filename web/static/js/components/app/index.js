import riot from 'riot'
import './app-header'
import './app-body'

const template = `
  <app-header></app-header>
  <app-body></app-body>
  <app-footer></app-footer>
`

riot.tag('app', template, function (opts) {
  this.on('mount', () => {
    // bootstrap material design once app is mounted
    $.material.init()

    // setup router
    riot.route.start(true)
  })
})

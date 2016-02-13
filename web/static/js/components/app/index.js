import riot from 'riot'
import './app-header'
import './app-body'
import './app-alert'

const template = `
  <app-header></app-header>
  <app-alert></app-alert>
  <app-body></app-body>
  <app-footer></app-footer>
`

riot.tag('app', template, function (opts) {
  this.on('mount', () => {

    // setup router
    riot.route.start(true)
  })
})

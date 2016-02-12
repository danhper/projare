import '../css/main.styl'
import './components'
import './mixins'
import riot from 'riot'

riot.route.base('/')

window.onload = () => {
  riot.mount('app')
}

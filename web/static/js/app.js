import '../css/main.styl'
import './components'
import riot from 'riot'

riot.route.base('/')

window.onload = () => {
  riot.mount('app')
}

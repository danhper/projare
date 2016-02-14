import '../css/main.styl'
import './components'
import './mixins'
import riot from 'riot'
import {categoryService} from 'services'

riot.route.base('/')

categoryService.list()

window.onload = () => {
  riot.mount('app')
}

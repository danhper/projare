import riot from 'riot'
import {userService} from 'services'
import {mountTag} from 'utils'

import './app-body.styl'

riot.tag('app-body', '', '', 'class="container"', function (opts) {
  riot.route('', () => {
    mountTag(this.root, 'projects-list')
  })
  riot.route('/projects/new', (name) => {
    mountTag(this.root, 'projects-new')
  })
  riot.route('/projects/my', (id) => {
    if (!userService.isLoggedIn()) {
      return riot.route('/')
    }
    mountTag(this.root, 'projects-list', {authorID: userService.currentUser.id})
  })
  riot.route('/projects/*', (id) => {
    mountTag(this.root, 'projects-show', {id: id})
  })
  riot.route('/projects/search..', () => {
    mountTag(this.root, 'projects-list', riot.route.query())
  })
  riot.route('/users/*', (id) => {
    mountTag(this.root, 'projects-list', {authorID: id})
  })

  // not found
  riot.route('..', () => riot.route('/'))
})

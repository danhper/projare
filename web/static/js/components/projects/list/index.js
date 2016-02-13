import riot from 'riot'

import './list.styl'

import {notificationManager} from 'utils'
import {projectService, userService} from 'services'

riot.tag('projects-list', require('./list.jade')(), function (opts) {
  const end = () => {
    this.loading = false
    this.update()
  }

  this.loadProjects = () => {
    const query = {
      offset: this.projects.length,
      q: opts.q,
      author_id: opts.authorID,
      reversed: true
    }
    this.loading = true
    return projectService.list(query)
      .then((res) => this.projects = this.projects.concat(res))
      .catch(e => this.error = e)
      .finally(end)
  }

  const titleForUser = () => {
    return userService.get(opts.authorID)
    .then((user) => `Projects by ${user.name}`)
    .catch(() => {
      notificationManager.notify('Could not find user', 'danger')
      riot.route('/')
    })
  }

  const getTitle = () => {
    if (opts.authorID) {
      if (userService.isLoggedIn() && opts.authorID === userService.currentUser.id) {
        return Promise.resolve('My projects')
      }
      return titleForUser()
    } else {
      return Promise.resolve(opts.q ? `Project search for "${opts.q}"` : 'Recent projects')
    }
  }

  getTitle().then((title) => {
    this.title = title
    this.update()
  })

  this.projects = []
})

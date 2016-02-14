import riot from 'riot'
import Promise from 'bluebird'

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
      category_name: opts.categoryName,
      reversed: true
    }
    this.loading = true
    return projectService.list(query)
      .then((res) => this.projects = this.projects.concat(res))
      .catch(e => this.error = e)
      .finally(end)
  }

  opts.title.then((title) => {
    this.title = title
    this.update()
  })

  this.projects = []
})

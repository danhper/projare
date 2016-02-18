import riot from 'riot'
import Promise from 'bluebird'

import './list.styl'

import {notificationManager} from 'utils'
import {projectService, userService} from 'services'

riot.tag('projects-list', require('./list.jade')(), function (opts) {
  this.mixin('load-entities')

  this.projects = []

  this.loadProjects = () => {
    const query = {
      offset: this.projects.length,
      q: opts.q,
      author_id: opts.authorID,
      category_name: opts.categoryName,
      reversed: !opts.ranking,
      ranking: opts.ranking
    }
    return this.loadEntities(projectService, {key: 'projects', query: query})
  }

  opts.title.then((title) => {
    this.title = title
    this.update()
  })
})

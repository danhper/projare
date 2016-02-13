import riot from 'riot'

import './list.styl'

import {projectService} from 'services'

riot.tag('projects-list', require('./list.jade')(), function (opts) {
  this.loadProjects = () => {
    const query = {
      offset: this.projects.length
    }
    if (opts.q) {
      query.q = opts.q
    }
    projectService.list(query).then((res) => {
      this.projects = res
    }).catch(e => this.error = e)
    .finally(() => this.update())
  }

  this.projects = []

  this.loadProjects()
})

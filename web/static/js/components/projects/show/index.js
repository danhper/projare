import riot from 'riot'

import './show.styl'

import {projectService} from 'services'

riot.tag('projects-show', require('./show.jade')(), function (opts) {
  this.mixin('star-project', 'auth-helpers', 'load-entity', 'delete-entity')

  this.loadEntity(opts.id, projectService, {key: 'project'})

  this.handleStarProject = () => {
    this['star-button'].blur()
    this.starProject(this.project)
  }

  this.handleDeleteProject = () => {
    this['delete-button'].blur()
    this.deleteEntity(this.project.id, projectService, {
      entityName: 'project',
      redirectPath: '/projects'
    })
  }
})

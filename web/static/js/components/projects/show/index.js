import riot from 'riot'

import './show.styl'

import {projectService} from 'services'

riot.tag('projects-show', require('./show.jade')(), function (opts) {
  this.mixin('star-project', 'auth-helpers')
  this.loading = true

  projectService.get(opts.id)
    .then(project => this.project = project)
    .catch(e => {
      this.error = e
      riot.route('/')
    })
    .finally(() => {
      this.loading = false
      this.update()
    })

  this.handleStarProject = () => {
    this['star-button'].blur()
    this.starProject(this.project)
  }
})

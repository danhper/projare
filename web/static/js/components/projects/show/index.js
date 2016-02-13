import riot from 'riot'

import {projectService} from 'services'

riot.tag('projects-show', require('./show.jade')(), function (opts) {
  projectService.get(opts.id)
    .then(project => this.project = project)
    .catch(e => this.error = e)
    .finally(() => this.update())
})

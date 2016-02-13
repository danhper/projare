import riot from 'riot'
import {projectService} from 'services'
import {notificationManager} from 'utils'

riot.tag('projects-new', require('./new.jade')(), function (opts) {
  this.mixin('login-required', 'form')

  this.createProject = () => {
    const project = this.fetchValues('title', 'url', 'description')
    projectService.create(project).then((project) => {
      notificationManager.notify('The project has been created')
      riot.route(`/projects/${project.id}`)
    }).catch(e => this.errors = this.formatErrors(e))
    .finally(() => this.update())
  }
})

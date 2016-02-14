import riot from 'riot'
import {projectService, categoryService} from 'services'
import {notificationManager} from 'utils'

riot.tag('projects-new', require('./new.jade')(), function (opts) {
  this.mixin('login-required', 'form')

  categoryService.list()
    .then(categories =>  this.categories = categories)
    .catch(_e => notificationManager.notify('Could not load categories, try again later', 'danger'))
    .finally(() => this.update())

  this.createProject = () => {
    this.loading = true
    const project = this.fetchValues('title', 'url', 'description', 'category_id')
    projectService.create(project).then((project) => {
      notificationManager.notify('The project has been created')
      riot.route(`/projects/${project.id}`)
    }).catch(e => this.errors = this.formatErrors(e))
    .finally(() => {
      this.loading = false
      this.update()
    })
  }
})

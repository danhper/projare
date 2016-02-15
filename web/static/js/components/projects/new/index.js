import riot from 'riot'
import {userService, projectService, categoryService} from 'services'
import {notificationManager} from 'utils'

import './new.styl'

riot.tag('projects-new', require('./new.jade')(), function (opts) {
  this.mixin('login-required', 'form', 'load-entity')

  this.project = {}
  if (opts.projectID) {
    this.loadEntity(opts.projectID, projectService, {key: 'project'})
      .then((project) => {
        if (project.author.id !== userService.currentUser.id) {
          riot.route('/')
        }
      })
  }

  categoryService.list()
    .then(categories =>  this.categories = categories)
    .catch(_e => notificationManager.notify('Could not load categories, try again later', 'danger'))
    .finally(() => this.update())

  this.saveProject = () => {
    this.startLoading({key: 'saving'})
    const values = this.fetchValues('title', 'url', 'description', 'category_id')
    Object.assign(this.project, values)
    projectService.save(this.project).then((project) => {
      notificationManager.notify('The project has been saved')
      riot.route(`/projects/${project.id}`)
    }).catch(e => this.errors = this.formatErrors(e))
    .finally(() => this.endLoading({key: 'saving', update: true}))
  }
})

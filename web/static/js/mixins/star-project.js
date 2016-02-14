import riot from 'riot'

import {userService, projectService} from 'services'
import {notificationManager} from 'utils'

riot.mixin('star-project', {
  starProject: function (project) {
    if (!userService.isLoggedIn()) {
      notificationManager.notify('Please login to star projects', 'danger')
      return
    }
    const original = Object.assign({}, project)
    project.starred = !project.starred
    project.starsCount += project.starred ? 1 : -1
    const verb = project.starred ? 'star' : 'unstar'
    projectService[verb](project.id, project.starred)
    .catch(e => {
      Object.assign(project, original)
      notificationManager.notify(`Failed to ${verb} project`, 'danger')
    }).finally(() => this.update())
  }
})

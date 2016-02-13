import riot from 'riot'
import {request} from 'utils'

class ProjectService {
  constructor() {
    riot.observable(this)
  }

  create(project) {
    return request.post('/api/projects', project).end()
  }
}

export default new ProjectService()

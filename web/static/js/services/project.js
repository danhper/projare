import riot from 'riot'
import {request} from 'utils'

class ProjectService {
  constructor() {
    riot.observable(this)
  }

  create(project) {
    return request.post('/api/projects', project).end()
  }

  list(query) {
    query = query || {}
    return request.get('/api/projects')
      .query(query)
      .end()
  }

  get(id) {
    return request.get(`/api/projects/${id}`).end()
  }
}

export default new ProjectService()

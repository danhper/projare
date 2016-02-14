import riot from 'riot'
import {request, authorizeRequest} from 'utils'

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

  star(id) {
    return request.post(`/api/projects/${id}/star`).end()
  }

  unstar(id) {
    return request.del(`/api/projects/${id}/star`).end()
  }
}

export default new ProjectService()

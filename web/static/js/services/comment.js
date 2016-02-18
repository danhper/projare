import {request, authorizeRequest} from 'utils'

class CommentService {
  constructor(basePath) {
    this.basePath = basePath
  }

  save(comment) {
    if (comment.id) {
      return request.put(`/api${this.basePath}/${comment.id}`, comment).end()
    }
    return request.post(`/api${this.basePath}`, comment).end()
  }

  list(query) {
    return request.get(`/api${this.basePath}`)
      .query(query)
      .end()
  }

  delete(id) {
    return request.del(`/api${this.basePath}/${id}`).end()
  }
}

export default CommentService

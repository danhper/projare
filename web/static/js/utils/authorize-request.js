import request from 'superagent'

const Request = request.Request
const originalEnd = Request.prototype.end

export default function (token) {
  Request.prototype.end = function (cb) {
    if (token) {
      this.header.Authorization = `Bearer ${token}`
    } else {
      delete this.header.Authorization
    }
    return originalEnd.call(this, cb)
  }
}

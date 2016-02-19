import riot from 'riot'
import {LocalStorage, request, authorizeRequest} from 'utils'

class UserService {
  constructor() {
    riot.observable(this)
    this._currentUser = null
    this.storage = new LocalStorage({prefix: 'user'})
    this._loadCurrentUser()
  }

  _loadCurrentUser() {
    this._currentUser = this.storage.get('current')
    this._authorize()
  }

  get currentUser() {
    return this._currentUser
  }

  set currentUser(user) {
    this.storage.set('current', user)
    this._currentUser = user
    this._authorize()
  }

  login(user) {
    return request.post('/api/login', user).end().then((user) => this._finalizeLogin(user))
  }

  facebookLogin(data) {
    return request.post('/api/login/facebook', data).end().then((user) => this._finalizeLogin(user))
  }

  _finalizeLogin(user) {
    this.currentUser = user
    return this.currentUser
  }

  logout() {
    this.storage.remove('current')
    this._currentUser = null
    authorizeRequest(null)
    riot.route('/')
  }

  isLoggedIn() {
    return this.currentUser !== null
  }

  signup(user) {
    return request.post('/api/users', user).end().then(res => {
      this.currentUser = res
      return this.currentUser
    })
  }

  get(id) {
    return request.get(`/api/users/${id}`).end()
  }

  _authorize() {
    if (this._currentUser) {
      authorizeRequest(this._currentUser.secretToken)
    }
  }
}

export default new UserService()

import riot from 'riot'
import {LocalStorage, request} from 'utils'

class UserService {
  constructor() {
    riot.observable(this)
    this._currentUser = null
    this.storage = new LocalStorage({prefix: 'user'})
    this._loadCurrentUser()
  }

  _loadCurrentUser() {
    this._currentUser = this.storage.get('current')
  }

  get currentUser() {
    return this._currentUser
  }

  set currentUser(user) {
    this.storage.set('current', user)
    this._currentUser = user
  }

  login(user) {
    return request.post('/api/login', user).end().then(res => {
      this.currentUser = res
      return this.currentUser
    })
  }

  logout() {
    this.storage.remove('current')
    this._currentUser = null
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
}

export default new UserService()

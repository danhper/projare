import riot from 'riot'
import {LocalStorage} from 'utils'

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

  isLoggedIn() {
    return this.currentUser !== null
  }
}

export default new UserService()

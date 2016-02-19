import Promise from 'bluebird'

import userService from './user'

class FacebookService {
  login() {
    const promise = new Promise((resolve, reject) => {
      FB.getLoginStatus((res) => {
        if (res.status === 'connected') {
          return this._finalizeLogin(res, resolve, reject)
        }
        return this._login(resolve, reject)
      })
    })
    return promise
  }

  _login(resolve, reject) {
    FB.login((res) => {
      if (res.status === 'connected') {
        return this._finalizeLogin(res, resolve, reject)
      }
      reject(new Error('Could not login'))
    }, {scope: 'email'})
  }

  _finalizeLogin(res, resolve, reject) {
    const data = {userID: res.authResponse.userID, token: res.authResponse.accessToken}
    return userService.facebookLogin(data).then(resolve).catch(reject)
  }
}

export default new FacebookService()

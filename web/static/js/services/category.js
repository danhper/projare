import Promise from 'bluebird'

import {request} from 'utils'

class CategoryService {
  list() {
    if (this._cachedCategories) {
      return Promise.resolve(this._cachedCategories)
    }
    return request.get('/api/categories').end().then(categories => {
      this._cachedCategories = categories
      return categories
    })
  }
}

export default new CategoryService()

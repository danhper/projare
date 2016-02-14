import riot from 'riot'

import './list.styl'

import {categoryService} from 'services'
import {notificationManager} from 'utils'

riot.tag('categories-list', require('./list.jade')(), function (opts) {
  categoryService.list()
    .then(categories => this.categories = categories)
    .catch(_e => notificationManager.notify('Could not load categories, try again later', 'danger'))
    .finally(() => this.update())
})

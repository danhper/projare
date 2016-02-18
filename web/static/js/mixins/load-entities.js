import riot from 'riot'

import {notificationManager} from 'utils'

const inList = function (list, elem) {
  for (const val of list) {
    if (val.id === elem.id) {
      return true
    }
  }
  return false
}

riot.mixin('load-entities', {
  init: function () {
    this.mixin('loading')
  },

  mergeLists: function (dest, newElems) {
    for (const newElem of newElems) {
      if (!inList(dest, newElem)) {
        dest.push(newElem)
      }
    }
  },

  loadEntities: function (service, options = {}) {
    const key = options.key || 'entities'
    const entitiesName = options.entitiesName || key || 'entities'
    this.startLoading()
    return service.list(options.query)
      .then((res) => {
        this.mergeLists(this[key], res)
        return res
      })
      .catch(_e => {
        notificationManager.notify(`Failed to load the ${entitiesName}`, 'danger')
      })
      .finally(() => this.endLoading({update: true}))
  }
})

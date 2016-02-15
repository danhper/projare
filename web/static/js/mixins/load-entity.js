import riot from 'riot'

import {notificationManager} from 'utils'

riot.mixin('load-entity', {
  init: function () {
    this.mixin('loading')
  },

  loadEntity: function (id, service, options = {}) {
    const key = options.key || 'entity'
    const entityName = options.entityName || key
    this.startLoading()
    return service.get(id)
      .then(entity => {
        this[key] = entity
        return entity
      })
      .catch(e => {
        notificationManager.notify(`Failed to load the ${entityName}`, 'danger')
        riot.route('/')
      })
      .finally(() => this.endLoading({update: true}))
  }
})

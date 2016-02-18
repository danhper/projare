import riot from 'riot'

import Promise from 'bluebird'
import {notificationManager} from 'utils'

riot.mixin('delete-entity', {
  init: function () {
    this.mixin('loading')
  },

  deleteEntity: function (id, service, options = {}) {
    if (this.deleting) {
      return
    }
    const entityName = options.entityName || 'entity'
    const redirectPath = options.redirectPath
    const confirmMessage = options.confirmMessage ||
      `Do you really want to delete the ${entityName}?`
    if (!options.skipConfirm && !window.confirm(confirmMessage)) {
      return Promise.reject('canceled')
    }
    this.startLoading({key: 'deleting'})
    return service.delete(id)
      .then(() => {
        notificationManager.notify(`The ${entityName} has been deleted.`, 'success')
        if (redirectPath) {
          riot.route(redirectPath)
        }
      })
      .catch(e => {
        notificationManager.notify(`Failed to delete the ${entityName}`, 'danger')
      })
      .finally(() => this.endLoading({update: true, key: 'deleting'}))
  }
})

import riot from 'riot'

import './comment.styl'

import {notificationManager} from 'utils'

riot.tag('comments-comment', require('./comment.jade')(), function (opts) {
  this.mixin('delete-entity', 'auth-helpers', 'format-helpers', 'loading')

  this.handleDelete = (_e) => {
    const comment = opts.comment
    this.deleteEntity(comment.id, opts.service, {entityName: 'comment'})
      .then(() => {
        if (opts.onDeleted) {
          opts.onDeleted({comment: opts.comment, index: opts.index})
        }
      })
  }

  this.startEditing = (_e) => this.editing = true
  this.stopEditing = (_e) => this.editing = false
  this.on('update', () => $.material.init())

  this.handleSave = (_e) => {
    const body = this.body.value
    this.startLoading({key: 'saving'})
    opts.service.save(Object.assign({}, opts.comment, {body: body}))
      .then(() => {
        opts.comment.body = body
        this.editing = false
      })
      .catch(() => notificationManager.notify('Could not update comment', 'danger'))
      .finally(() => this.endLoading({key: 'saving', update: true}))
  }
})

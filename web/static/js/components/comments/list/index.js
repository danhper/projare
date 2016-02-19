import riot from 'riot'

import './list.styl'

import {CommentService} from 'services'
import {notificationManager} from 'utils'

riot.tag('comments-list', require('./list.jade')(), function (opts) {
  this.mixin('load-entities', 'auth-helpers')

  this.on('update', () => {
    // when project is null, path looks like /projects//comments
    if (opts.basePath.indexOf('//') !== -1) {
      return
    }
    this.loaded = true
    this.commentService = new CommentService(opts.basePath)
    if (!this.comments) {
      this.comments = []
      this.count = opts.count
      this.loadComments()
    }
  })

  this.loadComments = () => {
    if (!this.commentService || this.deleting) {
      return Promise.resolve()
    }
    const query = {
      offset: this.comments.length,
    }
    return this.loadEntities(this.commentService, {key: 'comments', query: query})
      .then(() => $.material.init())
  }

  this.handleSave = (_e) => {
    this.startLoading({key: 'saving'})
    this.commentService.save({body: this.body.value})
      .then((comment) => {
        this.count++
        this.comments.push(comment)
        this.body.value = ''
      })
      .catch(() => notificationManager.notify('Could not save comment', 'danger'))
      .finally(() => this.endLoading({key: 'saving', update: true}))
  }

  this.handleDelete = (options) => {
    this.count--
    this.comments.splice(options.index, 1)
    this.update()
  }
})

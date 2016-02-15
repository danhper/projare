import riot from 'riot'
import Promise from 'bluebird'
import {userService, categoryService} from 'services'
import {mountTag, notificationManager} from 'utils'
import find from 'lodash.find'

import './app-body.styl'

riot.tag('app-body', '', '', 'class="container"', function (opts) {
  const errorAndRedirect = (message) => {
    return (e) => {
      notificationManager.notify(message, 'danger')
      riot.route('/')
    }
  }

  riot.route('', () => {
    mountTag(this.root, 'projects-list', {title: Promise.resolve('Recent projects')})
  })

  riot.route('/projects/new', () => {
    mountTag(this.root, 'projects-new', {
      title: 'Create project',
      buttonText: 'Create'
    })
  })

  riot.route('/projects/*/edit', (id) => {
    if (!userService.isLoggedIn()) {
      return errorAndRedirect('You must login to see this page')()
    }
    mountTag(this.root, 'projects-new', {
      projectID: id,
      title: 'Edit project',
      buttonText: 'Save'
    })
  })

  riot.route('/projects/my', () => {
    if (!userService.isLoggedIn()) {
      return errorAndRedirect('You must login to see this page')()
    }
    mountTag(this.root, 'projects-list', {
      authorID: userService.currentUser.id,
      title: Promise.resolve('My projects')
    })
  })

  riot.route('/projects/*', (id) => {
    mountTag(this.root, 'projects-show', {id: id})
  })

  riot.route('/projects/search..', () => {
    mountTag(this.root, 'projects-list', Object.assign(riot.route.query(), {
      title: Promise.resolve(`Project search for "${riot.route.query().q}"`)
    }))
  })

  riot.route('/users/*', (id) => {
    mountTag(this.root, 'projects-list', {
      authorID: id,
      title: userService.get(id)
        .then((user) => `Projects by ${user.name}`)
        .catch(errorAndRedirect('Could not find user'))
    })
  })

  riot.route('/categories', () => {
    mountTag(this.root, 'categories-list')
  })

  riot.route('/categories/*', (name) => {
    mountTag(this.root, 'projects-list', {
      categoryName: name,
      title: categoryService.list().then(categories => {
        const category = find(categories, {normalizedName: name})
        if (category) {
          return `Projects in ${category.name}`
        }
        throw new Error('no such category')
      }).catch(errorAndRedirect(`Could not find category ${name}`))
    })
  })

  // not found
  riot.route('..', () => riot.route('/'))
})

import riot from 'riot'

import {infiniteScroll} from 'utils'

const template = `
  <spinner
    if="{ loading && !opts.noSpinner }"
    color="{ opts.spinnerColor }"
    size="{ opts.spinnerSize }"></spinner>`

// NOTE: callback must return a promise if given
riot.tag('infinite-scroll', template, function (opts) {
  this.loading = false

  const end = (done) => {
    this.loading = false
    done()
    this.update()
  }

  const callback = (done) => {
    this.loading = true
    if (!opts.onInfinite) {
      return end(done)
    }
    opts.onInfinite().finally(() => end(done))
  }

  let disableScroll = null

  this.on('mount', () => {
    disableScroll = infiniteScroll({
      distance: opts.distance || 50,
      callback: callback
    })
  })
  this.on('unmount', () => {
    if (disableScroll) {
      disableScroll()
    }
  })

  if (opts.autoLoad) {
    callback(() => null)
  }
})

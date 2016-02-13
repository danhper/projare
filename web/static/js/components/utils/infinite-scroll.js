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

  infiniteScroll({
    distance: opts.distance || 50,
    callback: callback
  })

  if (opts.autoLoad) {
    callback(() => null)
  }
})

import riot from 'riot'

riot.mixin('loading', {
  startLoading: function (options = {}) {
    const key = options.key || 'loading'
    this[key] = true
    if (options.update) {
      this.update()
    }
  },

  endLoading: function (options = {}) {
    const key = options.key || 'loading'
    this[key] = false
    if (options.update) {
      this.update()
    }
  }
})

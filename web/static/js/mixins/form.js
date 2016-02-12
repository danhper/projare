import riot from 'riot'

riot.mixin('form', {
  fetchValues: function (...keys) {
    const result = {}
    for (const key of keys) {
      if (this[key] && this[key].value) {
        result[key] = this[key].value
      }
    }
    return result
  },

  formatErrors: function (e) {
    if (!(e && e.response && e.response.body && e.response.body.errors)) {
      return {global: 'An error has occured, please try again later'}
    }
    const errors = e.response.body.errors
    const result = {}
    for (const field of Object.keys(errors)) {
      result[field] = `${field} ${errors[field][0]}`
    }
    return result
  },

  hasError: function (field) {
    return this.errors && this.errors[field]
  },

  getError: function (field) {
    if (this.hasError(field)) {
      return this.errors[field]
    }
  }
})

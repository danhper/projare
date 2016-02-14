import riot from 'riot'

import convertCase from 'case'

riot.mixin('form', {
  init: function () {
    this.errors = {}
    this.on('mount', () => {
      for (const tag of this.tags['form-row']) {
        tag.on('change', (field) => {
          if (this.errors.hasOwnProperty(field)) {
            delete this.errors[field]
            this.update()
          }
        })
      }
    })
  },


  fetchValues: function (...keys) {
    const result = {}
    for (const key of keys) {
      if (this[key] && this[key].value) {
        result[key] = this[key].value
        continue
      }
      for (const tag of this.tags['form-row']) {
        const val = tag.inputValue && tag.inputValue(key)
        if (val) {
          result[key] = val
          continue
        }
      }
    }
    return result
  },

  formatErrors: function (e) {
    if (e && e.response && e.response && e.response.error) {
      return {global: e.response.error}
    }
    if (!(e && e.response && e.response.errors)) {
      return {global: 'An error has occured, please try again later'}
    }
    const errors = e.response.errors
    const result = {}
    for (const field of Object.keys(errors)) {
      result[field] = `${convertCase.lower(field)} ${errors[field][0]}`
    }
    return result
  },

  hasError: function (field) {
    return this.errors && this.errors[this._errorField(field)]
  },

  getError: function (field) {
    field = this._errorField(field)
    if (this.hasError(field)) {
      return this.errors[field]
    }
  },

  _errorField: function (field) {
    return convertCase.camel(field)
  }
})

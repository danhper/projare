export default class LocalStorage {
  constructor(options) {
    this.options = options || {}
    this.window = options.window || window
  }

  get prefix() {
    return this.options.prefix || ''
  }

  get(key) {
    const value = this.window.localStorage[this._withPrefix(key)]
    if (value) {
      try {
        return JSON.parse(value)
      } catch (_e) {}
    }
    return null
  }

  set(key, value) {
    this.window.localStorage[this._withPrefix(key)] = JSON.stringify(value)
  }

  _withPrefix(key) {
    if (!this.prefix) {
      return key
    }
    return `${this.prefix}-${key}`
  }
}

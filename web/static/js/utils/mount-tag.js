import riot from 'riot'

export default function (...args) {
  riot.mount(...args)
  $.material.init()
  window.scrollTo(0, 0)
}

import riot from 'riot'

riot.tag('event-list', require('./event-list.jade')(), function (opts) {
  console.log('event list')
})

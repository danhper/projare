import superagent from 'superagent'
import superagentPromise from 'superagent-promise'
import Promise from 'bluebird'
import serializer from 'superagent-serializer'

serializer(superagent, 'camel')

export default superagentPromise(superagent, Promise)

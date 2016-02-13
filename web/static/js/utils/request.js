import superagent from 'superagent'
import superagentPromise from 'superagent-promise'
import Promise from 'bluebird'
import serializer from 'superagent-serializer'

Promise.config({
  warnings: {
    wForgottenReturn: false
  }
})

serializer(superagent, 'camel')

export default superagentPromise(superagent, Promise)

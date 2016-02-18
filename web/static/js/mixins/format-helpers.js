import riot from 'riot'

import {secondsToPeriod} from 'utils'

riot.mixin('format-helpers', {
  timeAgo: function (val) {
    if (!(val instanceof Date)) {
      val = new Date(Date.parse(val))
    }
    const seconds = (new Date().getTime() - val.getTime()) / 1000
    return `${secondsToPeriod(seconds)} ago`
  }
})

const pluralize = function (word, count) {
  if (count === 1) {
    return word
  }
  return `${word}s`
}

export default function (seconds) {
  const periods = ['second', 'minute', 'hour', 'day', 'week', 'month', 'year']
  const durations = [1, 60, 3600, 24 * 3600, 7 * 24 * 3600, 30 * 24 * 3600, 365 * 3600]
  for (let i = 0; i < periods.length; i++) {
    if (i + 1 >= periods.length || seconds < durations[i + 1]) {
      const duration = Math.round(seconds / durations[i])
      return `${duration} ${pluralize(periods[i])}`
    }
  }
}

'use strict';

var
  request = require('request');

function origin (port) {
  return 'localhost:' + (port || 80);
}

function endpoint (port, endpoint) {
  return origin(port) + (endpoint || '/');
}

module.exports = {
  origin: origin,
  endpoint: endpoint
}

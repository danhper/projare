'use strict';

var
  request = require('request');

function origin (appname) {
  return appname + '.herokuapp.com';
}

function endpoint (appname, endpoint) {
  return origin(appname) + (endpoint || '/');
}

module.exports = {
  origin: origin,
  endpoint: endpoint
}

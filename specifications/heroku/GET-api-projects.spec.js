'use strict';

var
  assert = require('chai').assert,
  spec   = require('api-first-spec'),
  heroku = require('./heroku'),
  appname = require('../../account.json').heroku_appname;

var API = spec.define({
  "endpoint": "/api/projects",
  "method": spec.Method.GET,
  "request": {
    "contentType": spec.ContentType.URLENCODED,
  },
  "response": {
    "contentType": spec.ContentType.JSON,
    "data": "any"
  }
});

describe("GET /api/projects", function () {
  var host = spec.host(heroku.origin(appname));

  it("should succeed", function (done) {
    host.api(API).success(done);
  });

});

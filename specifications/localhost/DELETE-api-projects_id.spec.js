'use strict';

var
  assert = require('chai').assert,
  spec   = require('api-first-spec'),
  localhost = require('./localhost');

var API = spec.define({
  "endpoint": "/api/projects/[id]",
  "method": spec.Method.DELETE,
  "request": {
    "contentType": spec.ContentType.URLENCODED,
  },
  "response": {
    "contentType": spec.ContentType.JSON,
    "data": "any"
  }
});

describe("DELETE /api/projects/:id", function () {
  function create (callback) {
    var options = {
      url: "http://" + localhost.endpoint(3000, '/api/projects'),
      method: "POST",
      json: true,
      form: {
        title: "Lorem",
        url: "https://example.com",
        description: "Lorem ipsum"
      }
    };
    require('request')(options, callback);
  }

  before(function (done) {
    create(function (err, resp, body) {
      project.id = body.id;
      project.title = body.title;
      project.url = body.url;
      project.description = body.description;
      done();
    });
  });
  var project = {};
  var host = spec.host(localhost.origin(3000));

  it("should be not found if not exists", function (done) {
    host.api(API).params({
      id: -1
    }).notFound(done);
  });

  it("should succeed if exsits", function (done) {
    host.api(API).params({
      id: project.id
    }).success(done);
  });

});

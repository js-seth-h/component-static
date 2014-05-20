// Generated by CoffeeScript 1.7.1
(function() {
  var glob, path,
    __hasProp = {}.hasOwnProperty;

  glob = require('glob');

  path = require('path');

  module["export"] = function(option, callback) {
    var result;
    if (!callback) {
      callback = option;
      option = {
        root: '.'
      };
    }
    result = {};
    return glob('**/component.json', {}, function(err, files) {
      var dir, file, json, prefix, staticDir, _i, _len, _ref;
      for (_i = 0, _len = files.length; _i < _len; _i++) {
        file = files[_i];
        json = require('./' + file);
        if (!json["static"]) {
          continue;
        }
        _ref = json["static"];
        for (prefix in _ref) {
          if (!__hasProp.call(_ref, prefix)) continue;
          staticDir = _ref[prefix];
          dir = path.dirname(file);
          result[prefix] = path.relative(option.root, path.join(dir, staticDir));
        }
      }
      return callback(result);
    });
  };

}).call(this);

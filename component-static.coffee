fs = require 'fs'
glob = require 'glob'
path = require 'path'
debug = require('debug')('component-static')

mergeJsons = (files, callback)->
  result = {}
  # console.log files
  cnt = files.length
  for file in files
    # json = require './' + file
    fs.readFile file, (err, data)->
      unless err
        try
          json = JSON.parse(data);
          if json.static 
            for own prefix, staticDir of json.static
              dir = path.dirname(file)
              result[prefix] = path.normalize path.join dir, staticDir  
              debug 'prefix : path = ', prefix, ' :', result[prefix]
        catch 
      cnt--
      if cnt is 0
        callback(result)



componentStatic = (callback)->
  glob '**/component.json',(err, files)->  
    return callback err if err
    return callback null, {} if files.length is 0
    debug 'found component.json', files.length, 'files', err
    mergeJsons files, (staticMapping)->
      callback null, staticMapping

module.exports = componentStatic

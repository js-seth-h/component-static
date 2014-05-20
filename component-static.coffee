
glob = require 'glob'
path = require 'path'

module.export = (option, callback)->

  unless callback
    callback = option
    option = {
      root: '.'
    }

  result = {}
  glob '**/component.json', {}, (err, files)->
    # console.log files
    for file in files
      json = require './' + file
      continue unless json.static 

      # console.log json.static

      for own prefix, staticDir of json.static
        dir = path.dirname(file)

        result[prefix] = path.relative option.root, path.join dir, staticDir  

    callback(result)

# module.export (staticMapping)-> console.log staticMapping
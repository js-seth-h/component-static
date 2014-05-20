fs = require 'fs'
glob = require 'glob'
path = require 'path'

mergeJsons = (files, callback)->
  return callback {} unless files
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
        catch 
      cnt--
      if cnt is 0
        callback(result)



componentStatic = (callback)->
  glob '**/component.json',(err, files)-> 
    mergeJsons files, (staticMapping)->
      callback staticMapping

# componentStatic.sync = ()->
#   files = glob.sync '**/component.json'
#   return mergeJsons files


module.exports = componentStatic




# console.log module.export.sync()
# console.log '-----------------'

# module.export (staticMapping)-> console.log staticMapping
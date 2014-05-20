
glob = require 'glob'
path = require 'path'

mergeJsons = (files)->
  result = {}
  # console.log files
  for file in files
    json = require './' + file
    continue unless json.static 

    # console.log json.static

    for own prefix, staticDir of json.static
      dir = path.dirname(file)

      result[prefix] = path.normalize path.join dir, staticDir  
  return result



componentStatic = (callback)->
  glob '**/component.json',(err, files)-> 
    callback mergeJsons files

componentStatic.sync = ()->
  files = glob.sync '**/component.json'
  return mergeJsons files


module.export = componentStatic




# console.log module.export.sync()
# console.log '-----------------'

# module.export (staticMapping)-> console.log staticMapping
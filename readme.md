# grunt-service

> start/stop/restart service( = background process), support kill by pidfile 

## Purpose

[grunt-shell][sh] and [grunt-shell-spawn][sp] has some obstacle in my experience. 
I want to start/restart my server code for developemnt.
But, these plugins remove readability of debug message, and can't kill process in window(my development environment)


## Features

* options pass to `childprocess.spawn`
* so, this supports full option of `childprocess.spawn` include `stdio: ignore`, `stdio: inherit`, `stdio: ['ignore','pipe','pipe']` and `stdio: [0, 1,2 ]`  
* kill process by `PID file`


 
## Getting Started

If you haven't used [grunt][] before, be sure to check out the [Getting Started][] guide, as it explains how to create a [gruntfile][Getting Started] as well as install and use grunt plugins. Once you're familiar with that process, install this plugin with this command:

```bash
$ npm install --save-dev grunt-service
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-service');
```

*Tip: the [load-grunt-tasks](https://github.com/sindresorhus/load-grunt-tasks) module makes it easier to load multiple grunt tasks.*

[grunt]: http://gruntjs.com
[Getting Started]: https://github.com/gruntjs/grunt/wiki/Getting-started


## Examples


### As a Developement Sever 
> Support [debug][debug] module & PID File for restart
[debug]: https://www.npmjs.org/package/debug

```coffee
    
trim = (str)->
  str.replace /(^\s*)|(\s*$)/gm, ""
fromLines = (patterns)->
  return trim(patterns).split('\n').map (pattern)->
    trim(pattern)

watchDirIgnore = fromLines """ 
.git
.gitignore
tmp
test
public
node_modules 
""" 

clientMatch = fromLines """
browser/*.coffee
module/*/browser/*.coffee
""" 

serverMatch = fromLines """
*.coffee
!browser
!**/browser/**
!Gruntfile.coffee 
"""


  grunt.initConfig   
    fastWatch:   
      cwd:
        dir : '.'
        ignoreSubDir : watchDirIgnore 
        trigger:
          server:  
            care : serverMatch
            tasks: ["service:server:restart"]
          client: 
            care : clientMatch    
            tasks: ["service:server:restart"]
    service: 
      server: 
        shellCommand : 'set DEBUG=* && coffee app.coffee'
        pidFile : (process.env.TMPDIR || process.env.TEMP) + '/app.pid'  
        options :
          stdio : 'inherit'

  grunt.loadNpmTasks('grunt-spawn');
  grunt.loadNpmTasks('grunt-fast-watch'); 
  grunt.registerTask('default', ['service:server', 'fastWatch:cwd']);
  
```

Run server and show it [debug][debug]  log without changes( inclulde coloring).

I make & use [grunt-fast-watch][grunt-fast-watch] instead `grunt-watch` several reason. see also [grunt-fast-watch][grunt-fast-watch].

[grunt-fast-watch]:  https://www.npmjs.org/package/grunt-fast-watch


### Create a folder named `test`.

```js
grunt.initConfig({
	spawn: {
		makeDir: {
			shellCommand: 'mkdir test'
      option: {
        failOnError: false
      }
		}
	}
});
```
Making direcity.
Evne if fail mkdir (because of already exists), No Error occured.

     
### Spwan direclty 

```js
grunt.initConfig({
  testDir: 'test3',
	spawn: {
		direct: {
      command: 'mkdir'
      args: ['<%= testDir %>']
		}
	}
});
```


#### Run command and display the output

Output a directory listing in your Terminal.

```js
grunt.initConfig({
	shell: {
		dirListing: {
			command: 'ls'
		}
	}
});
``` 
 


## options
	
options will pass to `childprocess.spawn` without changes

so, please refer [Node.js API Document](http://www.nodejs.org/api/child_process.html#child_process_child_process_spawn_command_args_options)

-  default value of `stdio` is 'pipe', it means grunt can read stdio.

And some added option are as follows:


### failOnError
 
Default: `false`
Type: `Boolean`

If false, exit code of command is ignored.
if true, exit code 0 mean success( continue next task ) otherwise grunt show error and stop

### async

Default: `true`
Type: `Boolean`

If true, the next task is to continue after the end of the command.
If false, the next task is to continue without blocking.


## License

(The MIT License)

Copyright (c) 2014 junsik &lt;js@seth.h@google.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[sh]: https://github.com/sindresorhus/grunt-shell 
[sp]: https://github.com/cri5ti/grunt-shell-spawn
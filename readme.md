#component-static

> read all 'component.json' in subdir, merging 'static' property



## Purpose

When I use [component][comp], I need a way to expose `resource` through HTTP. 
Not by `build process`, purely http access to `static resources` like images, html, json, xml and so on. 

I need a tookit, but I can't find. So I made.

[comp]: https://github.com/component
## How to use

make custom propery `static` on `component.json`


```json
{
  "name": "login",
 
  "scripts": [
    "*.coffee"
  ],
  "styles": [
    "*.less"
  ],
  "templates": [
    "*.html"
  ],

  "static": {
    "/login": "./public"
  }
}
```  

it means, url start with `/login` should map to `./public`.

If location of `component.json` is 'client/login/component.json', `/login` should map to 'client/login/public'.

By this, In login component, access `static resource` by url like 'http://localhost/login/button.jpg'.


## How to use

[hand-static][hs] is support `url prefix mapping`. 

[hs]: https://github.com/js-seth-h/hand-static 

So, use like follows.

```coffee
    componentStatic = require 'component-static'

    componentStatic (err, staticMapping)->
      server = http.createServer ho.make [
        #... something you need
        statics staticMapping
      ]
# or With Connect

      app = connect()
      #... something you need
      app.use statics staticMapping
      
``` 


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


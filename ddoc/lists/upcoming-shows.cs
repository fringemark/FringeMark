(head,req) ->
  ddoc = this;
  mustache = require("vendor/couchapp/lib/mustache")
  path = require("vendor/couchapp/lib/path").init(req)
  data = {}
  
  start {'headers': {'Content-Type':"text/html"}}
    
  while(row=getRow())
    data[row.key[1]] = {"name": row.value[0], "id": row.value[1]}
    data["slot"] = ddoc.data.slots[row.key[0]][1]
      
  
  send(mustache.to_html(ddoc.templates.upcoming,data))
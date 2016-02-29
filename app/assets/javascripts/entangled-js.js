var Entangled=function(){function e(e,t,o,s){for(var n in e)e.hasOwnProperty(n)&&(this[n]=e[n]);this.socket=t,this.webSocketUrl=function(){if(s){var e=":"+s+"Id",t=this[s+"Id"],r=this.socket.replace(e,t);return r}return this.socket},o&&(this[o]=function(){return new r(this.webSocketUrl()+"/"+this.id+"/"+o)}),s&&(this[s]=function(e){var t=this.webSocketUrl().split("/"),o=t.slice(t.length-6,4).join("/"),n=new r(o),i=this[s+"Id"];n.find(i,function(t,r){t?e(t):e(null,r)})}.bind(this))}function t(t,r,o){this.all=[];for(var s=0;s<t.length;s++){var n=new e(t[s],r,o);this.all.push(n)}}function r(e){this.webSocketUrl=e}return e.prototype.$save=function(e){if(this.id){var t=new WebSocket(this.webSocketUrl()+"/"+this.id+"/update");t.onopen=function(){t.send(this.asSnakeJSON())}.bind(this),t.onmessage=function(t){if(t.data){var o=JSON.parse(t.data);if(o.error)return void(e&&e(new Error(o.error)));if(o.resource)for(key in o.resource)this[key]=o.resource[key]}this[this.hasMany]=new r(this.webSocketUrl()+"/"+this.id+"/"+this.hasMany),e&&e(null,this)}.bind(this)}else{var t=new WebSocket(this.webSocketUrl()+"/create");t.onopen=function(){t.send(this.asSnakeJSON())}.bind(this),t.onmessage=function(t){if(t.data){var r=JSON.parse(t.data);if(r.error)return void(e&&e(new Error(r.error)));if(r.resource)for(key in r.resource)this[key]=r.resource[key]}e&&e(null,this)}.bind(this)}},e.prototype.$update=function(e,t){for(var r in e)e.hasOwnProperty(r)&&(this[r]=e[r]);this.$save(t)},e.prototype.$destroy=function(e){var t=new WebSocket(this.webSocketUrl()+"/"+this.id+"/destroy");t.onopen=function(){t.send(null)},t.onmessage=function(t){if(t.data){var r=JSON.parse(t.data);if(r.error)return void(e&&e(new Error(r.error)));if(r.resource)for(key in r.resource)this[key]=r.resource[key];this.destroyed=!0,Object.freeze(this)}e&&e(null,this)}.bind(this)},e.prototype.$valid=function(){return!(this.errors&&Object.keys(this.errors).length)},e.prototype.$invalid=function(){return!this.$valid()},e.prototype.$persisted=function(){return!(this.$newRecord()||this.$destroyed())},e.prototype.$newRecord=function(){return!this.id},e.prototype.$destroyed=function(){return!!this.destroyed},e.prototype.asSnakeJSON=function(){var e,t=this,r={};return Object.keys(this).forEach(function(o){t.hasOwnProperty(o)&&(e=o.match(/[A-Za-z][a-z]*/g).map(function(e){return e.toLowerCase()}).join("_"),r[e]=t[o])}),JSON.stringify(r)},r.prototype.hasMany=function(e){this.hasMany=e},r.prototype.belongsTo=function(e){this.belongsTo=e},r.prototype["new"]=function(t){return new e(t,this.webSocketUrl,this.hasMany,this.belongsTo)},r.prototype.all=function(r){var o=new WebSocket(this.webSocketUrl);o.onmessage=function(s){if(s.data.length){var n=JSON.parse(s.data);if(n.error)return void r(new Error(n.error));if(n.resources)this.resources=new t(n.resources,o.url,this.hasMany);else if(n.action)if("create"===n.action)this.resources.all.push(new e(n.resource,o.url,this.hasMany));else if("update"===n.action){for(var i,a=0;a<this.resources.all.length;a++)this.resources.all[a].id===n.resource.id&&(i=a);this.resources.all[i]=new e(n.resource,o.url,this.hasMany)}else if("destroy"===n.action){for(var i,a=0;a<this.resources.all.length;a++)this.resources.all[a].id===n.resource.id&&(i=a);this.resources.all.splice(i,1)}else console.log("Something else other than CRUD happened..."),console.log(n)}r(null,this.resources.all)}.bind(this)},r.prototype.create=function(e,t){var r=this["new"](e);r.$save(t)},r.prototype.find=function(t,r){var o=this.webSocketUrl,s=new WebSocket(o+"/"+t);s.onmessage=function(t){if(t.data.length){var s=JSON.parse(t.data);if(s.error)return void r(new Error(s.error));s.resource&&!s.action?this.resource=new e(s.resource,o,this.hasMany):s.action?"update"===s.action?this.resource=new e(s.resource,o,this.hasMany):"destroy"===s.action&&(this.resource=void 0):(console.log("Something else other than CRUD happened..."),console.log(s))}r(null,this.resource)}.bind(this)},r}();
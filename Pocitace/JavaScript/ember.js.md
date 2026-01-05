==== Ember.js ====
=== Object model ===
== Classes and Instances ==
- define a new class - Ember.Object.extend
- subclass a class   - Ember.SuperClass.extend
  - values given are class-level attributes, functions -> methods
  - you can call call @_super
- create instance - Person.create
  - makes methods and properties available to instances
  - takes hash ov initial property values
  - define init method as initializer
  - may sure to call _super when subclassing embrer classes
  - use get and set to access properties - computed properties, observers, ...
- reopen class - Class.reopen
  - add instance methods and properties that are shared across all instances of a class
  - you can override existing methods and call _super (what does it do?)
- reopenClass - add static methods or static properties
  - updates 'instance' attributes of the class object

```js
// add static property to class
Person.reopenClass({
  isPerson: false
});
// override property of Person instance
Person.reopen({
  isPerson: true
});

Person.isPerson; // false - because it is static property created by `reopenClass`
Person.create().get("isPerson"); // true
```

== Computed properties ==
- declare functions as properties
```js
Person = Ember.Object.extend({
  // these will be supplied by `create`
  firstName: null,
  lastName: null,

  fullName: Ember.computed('firstName', 'lastName', function() {
    return this.get('firstName') + ' ' + this.get('lastName');
  })
});
```
- can be chained
- can be used as setters
  - first param is the property name
  - second param is the value to be set (e.g. split over two basic properties)
  - check number of params to determin (value == undefined)
- special dependet keys
  - e.g. todos.@each.isDone
  - cannot be nested more - e.g. todos.@each.owner.name, todos.@each.owner.@each.name

== Observers ==
```js
Person = Ember.Object.extend({
  // these will be supplied by `create`
  firstName: null,
  lastName: null,

  fullName: Ember.computed('firstName', 'lastName', function() {
    var firstName = this.get('firstName');
    var lastName = this.get('lastName');

    return firstName + ' ' + lastName;
  }),

  fullNameChanged: Ember.observer('fullName', function() {
    // deal with the change
  })
});

person.set('firstName', 'asdf') // observer fires
```

- beware
  - observers are synchornous -> bugs when properties are not yet synchronized
    - e.g. observer observing A accesses value of computed property which depends on A
  - may fire more times, when observing multiple properties
  -> use Ember.run.once:
```js
Person.reopen({
  partOfNameChanged: Ember.observer('firstName', 'lastName', function() {
    Ember.run.once(this, 'processFullName');
  }),

  processFullName: Ember.observer('fullName', function() {
    // This will only fire once if you set two properties at the same time, and
    // will also happen in the next run loop once all properties are synchronized
    console.log(this.get('fullName'));
  })
});

person.set('firstName', 'John');
person.set('lastName', 'Smith');
```

- not run during init, if you need to, use
```js
salutationDidChange: Ember.on('init', Ember.observer('salutation', function() {
  // some side effect of salutation changing
}))
```

- observers fire when property is first accessed (using get), if never accessed, observers never
  fire

- properties of other objects can be observed using
```js
person.addObserver('fullName', function() {
  // deal with the change
});
```

== Bindings ==
- creates a link between two properties such that when one changes, the other one is updated to the
  new value automatically
- easiest way to create a two-way binding is to use a computed alias, that specifies the path to
  another object
```js
wife = Ember.Object.create({
  householdIncome: 80000
});

Husband = Ember.Object.extend({
  householdIncome: Ember.computed.alias('wife.householdIncome')
});

husband = Husband.create({
  wife: wife
});

husband.get('householdIncome'); // 80000

// Someone gets raise.
wife.set('householdIncome', 90000);
husband.get('householdIncome'); // 90000
// works both ways

// one way bindings:
UserView = Ember.View.extend({
  userName: Ember.computed.oneWay('user.fullName')
});
```

== Enumerables ==
- most common Enumerable in the majority of apps is the native JavaScript array, which Ember.js
  extends to conform to the Enumerable interface
- all Enumerables support the standard forEach method
- general, Enumerable methods, like forEach, take an optional second parameter, which will become
  the value of this in the callback function

```js
var array = [1,2,3];

array.forEach(function(item) {
  console.log(item, this.indexOf(item));
}, array)

//=> 1 0
//=> 2 1
//=> 3 2

// Ember.Set - data structure that can efficiently answer whether it includes an object
// forEach
var food = ["Poi", "Ono", "Adobo Chicken"];

food.forEach(function(item, index) {
  console.log('Menu Item %@: %@'.fmt(index+1, item));
});

// Menu Item 1: Poi
// Menu Item 2: Ono
// Menu Item 3: Adobo Chicken

// toArray - creates a native array copy
// firstObject, lastObject - properties:
var animals = ["rooster", "pig"];

animals.get('lastObject');
//=> "pig"

animals.pushObject("peacock");

animals.get('lastObject');
//=> "peacock"

// map
words.map(function(item) {
  return item + "!";
});

// mapBy
var hawaii = Ember.Object.create({
  capital: "Honolulu"
});

var california = Ember.Object.create({
  capital: "Sacramento"
});

var states = [hawaii, california];

states.mapBy('capital');
//=> ["Honolulu", "Sacramento"]
```

- enum.filter(function(item, index, self))
- enum.filterBy(property, value)
- enum.every(function(item, index, self))
- enum.some(function(item, index, self))
- enum.isEvery(property, value)
- enum.isAny(property, value)

=== Templates ===
- use naming conventions - route renders template with the same name
- contain expressions
- may access attributes from controller
- use outlet to render nested template (for nested route)
- block expressions
  - #if, else if, else, /if
  - #unless, /unless
  - #each collection [key="id"] as |item|, [else - if none], /each
  - when key property specified, ember may effectively re-render on change
    - special values - @index (of item in array), @item (itself), @guid (generate unique for each
      object)

== Binding element attributes ==
```hbs
<img src={{logoUrl}} alt="Logo">
<input type="checkbox" disabled={{isAdministrator}}>
```

- view helpers ignore data attributes
  - to enable them - http://guides.emberjs.com/v1.13.0/templates/binding-element-attributes/ -
    at the bottom

== Binding element class names ==
- `<div class={{priority}}>`
- conditional - `<div class={{if isUrgent 'is-urgent' ['is-not-urgent']}}>`
  - non-block form of if
  - if no else branch, no class is added

== Links ==
```js
Router.map(function() {
  this.route("photos", function(){
    this.route("edit", { path: "/:photo_id" });
  });
});
```

```hbs
<ul>
  {{#each photos as |photo|}}
    <li>{{#link-to 'photos.edit' photo}}{{photo.title}}{{/link-to}}</li>
  {{/each}}
</ul>
```

- takes
  - name of a route
  - at most one model (.id will be used) for each dynamic segment (or explicit value e.g. index in
    array)
  - link has class="active" if current path matches it
- nested routes - multiple segments:
```js
Router.map(function() {
  this.route("photos", function(){
    this.route("photo", { path: "/:photo_id" }, function(){
      this.route("comments");
      this.route("comment", { path: "/comments/:comment_id" });
    });
  });
});
```

`{{#link-to 'photos.photo.comment' primaryComment}}Main Comment{{/link-to}}`
- only one model specified - will represent innermost dynamic segment (rightmost - :comment_id),
  photo_id will use the current photo

`{{#link-to 'photo.comment' 5 primaryComment}}sadf{{/link-to}}`
- model hook for PhotoRoute will run with params.photo_id = 5
- the model hook for CommentRoute won't run since you supplied a model object for the comment
  segment
- the comment's id will populate the url according to CommentRoute's serialize hook

- inline form - `{{link-to 'Inline Form' 'index'}}`
- may contain additional attributes for the link
- use replace=true to replace the current entry in the browser's history - can't return back

== Actions ==
`<button {{action 'contract'}}>Contract</button>`
- will call action on the controller (or route, or component?)

```hbs
// app/templates/post.hbs
<div class='intro'>
  {{intro}}
</div>

{{#if isExpanded}}
  <div class='body'>{{body}}</div>
  <button {{action 'contract'}}>Contract</button>
{{else}}
  <button {{action 'expand'}}>Show More...</button>
{{/if}}
```
``
```js
# app/controllers/post.js
PostController = Ember.Controller.extend({
  intro: Ember.computed.alias('model.intro'),
  body: Ember.computed.alias('model.body'),

  // initial value
  isExpanded: false,

  actions: {
    expand() {
      this.set('isExpanded', true);
    },

    contract() {
      this.set('isExpanded', false);
    }
  }
});
```

- action triggers method on template's controller
- if not implemented (present in actions), sent to current leaf route
- if not implemented (or route handler returns true), bubbles to parent route, ..., ApplicationRoute
- if none implements, error will be thrown

- any perameter passed to action helper after action name will be passed to handler

- you can specify on="event", use dasherized event names

- the {{action}} helper will ignore click events with pressed modifier keys
- you can supply an allowedKeys option to specify which keys should not be ignored

- by default, event.preventDefault() is called on all events handled by {{action}} helpers. To avoid
  this you can add preventDefault=false

- by default, the {{action}} helper allows events it handles to bubble up to parent DOM nodes. If
  you want to stop propagation, you can disable propagation to the parent node
`<button {{action 'close' bubbles=false}}>✗</button>`

- components can handle events from their templates

== Input helpers ==
http://guides.emberjs.com/v1.13.0/templates/input-helpers/

== Development helpers ==
- log
- debugger - will have access to get function - retrieves values in template context
```hbs
{{#each items as |item|}}
  {{debugger}}
{{/each}}
> get('item.name')
> context
```

== Rendering helpers ==
- `partial <template name>` - does not change scope
- `render <template> <model>` - model will be passed to controller if provided - template can access
  controller's attributes (and model's through it)
  - does not require presence of a matching route (neither does partial)
- outlet - router determines nested route, finds template, sets up controller, model
http://guides.emberjs.com/v1.13.0/templates/rendering-with-helpers/

== Writing helpers ==
ember generate helper format-currency
```js
# app/helpers/format-currency.js
import Ember from "ember";

CurrencyHelper = Ember.Helper.helper(function([value]) { # destructuring of array
  let dollars = Math.floor(value / 100),
      cents = value % 100,
      sign = '$';

  if (cents.toString().length === 1) { cents = '0' + cents; }
  return `${sign}${dollars}.${cents}`;
});
```

```hbs
# template.hbs
Your total is {{format-currency model.totalDue}}.
```

- named arguments - second param to helper function is a js object (hash which allows dot access)
```js
Ember.Helper.helper(function(params, { option1, option2, option3 }) { # destructuring of options
...
}
```

- stateful helpers
```js
CurrencyHelper Ember.Helper.extend({ # extend instead of helper
  compute(params, hash) {
    ...
  }
});
```

- ember escapes values returned from helpers, return Ember.String.htmlSafe(`asfd`) to avoid escaping
- use Handlebars.Utils.escapeExpression to escape manually
```js
BoldHelper = Ember.Helper.helper(function(params) {
  let value = Handlebars.Utils.escapeExpression(params[0]);
  return Ember.String.htmlSafe(`<b>${value}</b>`);
});
```

- adding services
http://guides.emberjs.com/v1.13.0/templates/writing-helpers/#toc_adding-services
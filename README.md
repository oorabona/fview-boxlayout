FView BoxLayout plugin
===

This is a [Meteor Famous Views](https://github.com/gadicc/meteor-famous-views)
plugin based on [Famo.us BoxLayout](https://github.com/IjzerenHein/famous-boxlayout).

Demo
----

Original demo is hosted [here](https://rawgit.com/IjzerenHein/famous-boxlayout/master/examples/demo/index.html)
and you can find this project demo [there](http://fview-boxlayout.meteor.com).

# Usage

The most exhaustive (yet basic) example to use BoxLayout.

```mustache
<template name="boxlayout">
  {{#BoxLayout margins=[]}}
    {{>Surface target="topLeft" template="box" class="topLeft"}}
    {{>Surface target="top" template="box" class="top"}}
    {{>Surface target="topRight" template="box" class="topRight"}}
    {{>Surface target="left" template="box" class="left"}}
    {{>Surface target="middle" template="middle" class="middle"}}
    {{>Surface target="right" template="box" class="right"}}
    {{>Surface target="bottomLeft" template="box" class="bottomLeft"}}
    {{>Surface target="bottom" template="box" class="bottom"}}
    {{>Surface target="bottomRight" template="box" class="bottomRight"}}
  {{/BoxLayout}}
</template>
```

You have examples on how to use the __margins__ parameter in the demo code.

># Note
> You do not need to specify all targets!

> All targets not needed by margins will show a warning in the console when added.
> Behind the scenes, the child element (Surface, ...) is created but not added to the DOM, hence the warning.

> E.g. In the example above, __margins__ is _empty_, so only 'middle' is expected.
> All other targets will produce a warning message. I did not want to throw an error although that would probably be considered as a leak.

That might be a problem, so in a real case world, and if you wanted it to be adaptive,
you would use a template like this one:

```mustache
<template name="boxLayout">
  {{#BoxLayout id="layout" margins=margins}}
    {{#each expectedTargets}}
      {{#if isEq this 'middle'}}
        {{>Surface target=this template="middle" class=this}}
      {{else}}
        {{>Surface target=this template="box" class=this}}
      {{/if}}
    {{/each}}
  {{/BoxLayout}}
</template>
```

Along with two helper functions:

```coffee
UI.registerHelper 'isEq', (x, y) ->
  x == y

Template.boxLayout.helpers
  expectedTargets: ->
    fview = FView.byId 'layout'
    fview.view._expectedTargets
```

> #Note
> I am using {{#each}}...{{/each}} and {{#if}}...{{/if}} here since we will
> never rely on Famo.us Surface reacitivity.

> Also, using #famous equivalent would change the inner workings of BoxLayout,
> making it a [0..n] container (like Scrollview) when we know that no more than
> 9 children will ever be needed.

# Demo

In the demo, if you want to play with reactive Session variables, you can
try to tweak the _Session_ variable called 'grid'.

```javascript
Session.get('grid');
```

And set (up to 9) margins wrapped around a single array.
The following example will show two _BoxLayout_, one with only 'middle' target
and the other with 20px border all sides.

```javascript
Session.set('grid', [[],[20]]);
```

Then if you want to return to the original demo margins, you can type this in your browser console:

```javascript
Session.set('grid', Demo.defaultGrid(60));
```

>#Note
>Use the Source, Luke.

# TODO

* ~~Modifier size change on-the-fly (a.k.a margins reactivity)~~
> In the demo, if you change margins with
```javascript
Session.set('grid', [[]]);
```
> all _BoxLayout_ will update existing _Surface_(s) sizes and if needs be, _Surface_(s) will
> be created or removed automagically! :smile:

* ~~Support {{#famousEach}}...{{/famousEach}} and {{#famousIf}}...{{/famousIf}}~~
> See above.

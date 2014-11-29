FView BoxLayout plugin
===

This is a [Meteor Famous Views](https://github.com/gadicc/meteor-famous-views)
plugin based on [Famo.us BoxLayout](https://github.com/IjzerenHein/famous-boxlayout).

Demo
----

Original demo is hosted [here](https://rawgit.com/IjzerenHein/famous-boxlayout/master/examples/demo/index.html)
and you can find this project demo [there](http://fview-boxlayout.meteor.com).

# Usage

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

> You do not need to specify all targets.

> All targets not needed by margins will show a warning in the console when added.
> It means that child is created but not added to the DOM.
> You can see what happens behind the scenes in the demo.

> E.g. in the above example, margins set up will only show the _target='middle'_ child. All other targets will show a warning.

That might be a problem, so in a real case world though, and if you wanted it to be adaptive,
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

> Note: I am using {{#each}}...{{/each}} and {{#if}}...{{/if}} here since we will
> never rely on Famo.us Surface reacitivity. Changing to #famous equivalents would
> require additional work to find the correct target child. See [TODO](#todo) below.

# TODO

* Support {{#famousEach}}...{{/famousEach}} and {{#famousIf}}...{{/famousIf}}

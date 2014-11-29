# Demo

FView.ready ()->
  famous.polyfills
  famous.core.famous

  FView.attrEvalAllowedKeys = ["transform"]
  FView.registerView 'GridLayout', famous.views.GridLayout
  return

Template.demo.helpers blocks: ->
  # Create example box-layouts
  SZ = 60
  [
    []
    [SZ]
    [
      SZ
      0
    ]
    [
      0
      SZ
    ]
    [
      SZ
      0
      0
      0
    ]
    [
      0
      SZ
      0
      0
    ]
    [
      0
      0
      SZ
      0
    ]
    [
      0
      0
      0
      SZ
    ]
    [
      SZ - 10
      SZ
      SZ - 20
      SZ + 10
    ]
  ]

UI.registerHelper 'isEq', (x, y) ->
  x == y

Template.boxLayout.helpers
  expectedTargets: ->
    fview = FView.byId 'layout'
    fview.view._expectedTargets

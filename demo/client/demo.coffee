# Demo

# Create example box-layouts
defaultGrid = (SZ) ->
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

Session.setDefault 'default_grid', defaultGrid 60

FView.ready ->
  famous.polyfills
  famous.core.famous

  FView.attrEvalAllowedKeys = ["transform"]
  FView.registerView 'GridLayout', famous.views.GridLayout
  return

Template.demo.helpers
  blocks: ->
    grid = Session.get 'default_grid'
    grid.map (margin, idx) ->
      {
        id: "layout-#{idx}"
        margins: margin
      }

UI.registerHelper 'isEq', (x, y) ->
  x == y

Template.boxLayout.helpers
  expectedTargets: ->
    fview = FView.byId @id
    fview.view._expectedTargets

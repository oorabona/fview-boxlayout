# Demo

# Create example box-layouts
@Demo =
  defaultGrid: (SZ=60) ->
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

# Sets default grid to the original demo size
Session.setDefault 'grid', Demo.defaultGrid 60

FView.ready ->
  famous.polyfills
  famous.core.famous

  FView.attrEvalAllowedKeys = ["transform"]
  FView.registerView 'GridLayout', famous.views.GridLayout
  return

Template.demo.helpers
  blocks: ->
    grid = Session.get 'grid'
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

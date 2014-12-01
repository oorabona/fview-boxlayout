# Adapted from https://github.com/IjzerenHein/famous-boxlayout

FView.ready ->
  # import dependencies
  FlexibleLayout = famous.views.FlexibleLayout
  View = famous.core.View
  Modifier = famous.core.Modifier
  RenderNode = famous.core.RenderNode

  ###*
  @class
  @extends View
  @param {Object} [options] Configuration options
  ###
  class BoxLayout extends View
    @DEFAULT_OPTIONS = margins: [] # top, right, bottom, left (clockwise)
    constructor: (@options) ->
      super @options

      @id = famous.core.Entity.register @
      @_update()
      return

  ###*
  Updates margins, called on construction and when updating attributes reactively.
  ###
  BoxLayout::_update = ->
    @_expectedTargets = []

    # normalize margins
    if @options.margins.length is 0
      @margins = [
        0
        0
        0
        0
      ]
    else if @options.margins.length is 1
      @margins = [
        @options.margins[0]
        @options.margins[0]
        @options.margins[0]
        @options.margins[0]
      ]
    else if @options.margins.length is 2
      @margins = [
        @options.margins[0]
        @options.margins[1]
        @options.margins[0]
        @options.margins[1]
      ]
    else
      @margins = @options.margins

    # create layout
    FView.log.debug "BoxLayout #{JSON.stringify @options} has margins #{@margins}"
    @add @_createLayout()

  ###*
  Creates and returns the top-level renderable
  ---
  Removed 'horizontal' parameter (unused)
  ###
  BoxLayout::_createLayout = ->
    margins = @margins
    ratios = undefined
    renderables = []
    if margins[1] and margins[3]
      ratios = [
        true
        1
        true
      ]
      renderables.push @_createVerticalLayout(0)
      renderables.push @_createVerticalLayout(1)
      renderables.push @_createVerticalLayout(2)
    else if margins[1]
      ratios = [
        1
        true
      ]
      renderables.push @_createVerticalLayout(1)
      renderables.push @_createVerticalLayout(2)
    else if margins[3]
      ratios = [
        true
        1
      ]
      renderables.push @_createVerticalLayout(0)
      renderables.push @_createVerticalLayout(1)
    else
      return @_createVerticalLayout(1)
    horzLayout = new FlexibleLayout(
      ratios: ratios
      direction: 0
    )
    horzLayout.sequenceFrom renderables
    horzLayout


  ###*
  Create vertical layout, index: left, middle, right
  ###
  BoxLayout::_createVerticalLayout = (index) ->
    margins = @margins
    ratios = undefined
    renderables = []
    if margins[0] and margins[2]
      ratios = [
        true
        1
        true
      ]
      renderables.push @_createRenderable(index)
      renderables.push @_createRenderable(index + 3)
      renderables.push @_createRenderable(index + 6)
    else if margins[0]
      ratios = [
        true
        1
      ]
      renderables.push @_createRenderable(index)
      renderables.push @_createRenderable(index + 3)
    else if margins[2]
      ratios = [
        1
        true
      ]
      renderables.push @_createRenderable(index + 3)
      renderables.push @_createRenderable(index + 6)
    else
      return @_createRenderable(index + 3)
    vertLayout = new FlexibleLayout(
      ratios: ratios
      direction: 1
    )
    vertLayout.sequenceFrom renderables
    modifier = undefined
    if index is 0
      modifier = new Modifier(size: [
        margins[3]
        `undefined`
      ])
    else if index is 2
      modifier = new Modifier(size: [
        margins[1]
        `undefined`
      ])
    if modifier
      renderNode = new RenderNode modifier
      renderNode.add vertLayout
      renderNode
    else
      vertLayout


  ###*
  Creates a renderable, index-order: left-top, top, top-right, left, middle, right, left-bottom, bottom, right-bottom
  ###
  BoxLayout::_createRenderable = (index) ->
    margins = @margins

    # determine size
    size = undefined
    name = undefined
    switch index
      when 0
        name = "topLeft"
        size = [
          margins[3]
          margins[0]
        ]
      when 1
        name = "top"
        size = [
          `undefined`
          margins[0]
        ]
      when 2
        name = "topRight"
        size = [
          margins[1]
          margins[0]
        ]
      when 3
        name = "left"
        size = [
          margins[3]
          `undefined`
        ]
      when 4
        name = "middle"
        size = [
          `undefined`
          `undefined`
        ]
      when 5
        name = "right"
        size = [
          margins[1]
          `undefined`
        ]
      when 6
        name = "bottomLeft"
        size = [
          margins[3]
          margins[2]
        ]
      when 7
        name = "bottom"
        size = [
          `undefined`
          margins[2]
        ]
      when 8
        name = "bottomRight"
        size = [
          margins[1]
          margins[2]
        ]

    # Save expected target name in our variables
    @_expectedTargets.push name

    # Check if we already have this surface in our tree.
    renderable = this[name]
    if renderable
      # If already exists, update size (maybe a better way than using _object ?)
      renderable._object.setSize size
    else
      # Create modifier and renderable
      modifier = new Modifier(size: size)
      renderable = new RenderNode(modifier)
      this[name] = renderable
    renderable

  FView.registerView 'BoxLayout', BoxLayout,
    add: (child_fview, child_options) ->
      target = child_options.target

      unless target
        throw new Error 'BoxLayout children must specify target="top[Left|Right]/left/middle/right/bottom[Left|Right]"'
      unless @view[target]
        FView.log.warn "#{target} will be discarded."
        return
      @view[target].add child_fview
    attrUpdate: (key,value) ->
      if key is 'margins'
        @view.options[key] = value
        @view._update()

  return

jQuery ->
  if $('#groups').length
    new GroupsPager()

class GroupsPager
  constructor: (@page = 1) ->
    $(window).scroll(@check)

  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#groups').data('json-url'), page: @page, @render)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50

  render: (groups) =>
    for group in groups
      $('#groups').append Mustache.to_html($('#group_template').html(), group)
    $(window).scroll(@check) if groups.length > 0

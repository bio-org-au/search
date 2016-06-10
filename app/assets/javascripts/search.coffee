window.debug = (s) ->
  try
    console.log('debug: ' + s) if debugSwitch == true
  catch error

window.notice = (s) ->
  try
    console.log('notice: ' + s)
  catch error

loadDetailsIfRequired = () ->
  debug('loadDetailsIfRequired')
  if $('#retrieve_details_on_load').val().match(/true/)
    $('#retrieve-details-control').click()

retrieveDetails = (event, $element) ->
  debug("retrieveDetails")
  $(".drill-down-toggle.hiding-details").click()
  $(".drill-down-toggle.no-details").filter(" :lt(50) ").click()

navNewSearch = (event, $element) ->
  $('#q').val('')
  $('#q').focus()
  false

# Hide/show details
# Load details if necessary
detailsToggle = (event, $element) ->
  debug("detailsToggle")
  nameId = $element.data("name-id")
  targetId = "name-#{nameId}"
  if $("##{targetId}").hasClass("hidden-xs-up")
    showTarget(targetId)
  else
    hideTarget(targetId)
  if $("#name-#{nameId}:empty").length == 0
    debug('not querying details')
    return false

needsDetailsLimit = (event, $element) ->
  href = $element.attr("href")
  detailsLimit = $("#details-limit-field").val()
  $element.attr("href","#{href}&details_limit=#{detailsLimit}")
  return true

searchForm = (event, $element) ->
  $("#details-limit").val($("#details-limit-field").val())
  true

drillDownToggle = (event, $element) ->
  debug("drillDownToggle")
  targetId = $element.data("target-id")
  if $("##{targetId}").hasClass("hidden-xs-up")
    debug('showing')
    $element.addClass("showing-details")
    $element.removeClass("no-details").removeClass("hiding-details")
    showTarget(targetId)
    $element.find('i.fa-caret-right').removeClass('fa-caret-right').addClass('fa-caret-down')
    resetControls()
    if $("##{targetId}:empty").length == 0
      keep_going()
    else
      stop()
  else
    debug('hiding...')
    hideTarget(targetId)
    $element.addClass("hiding-details")
    $element.removeClass("showing-details")
    $element.find('i.fa-caret-down').removeClass('fa-caret-down').addClass('fa-caret-right')
    resetControls()
    event.preventDefault()
    event.stopPropagation()

showTarget = (targetId) ->
  $("##{targetId}").removeClass("hidden-xs-up")
  $("##{targetId}").removeClass("hidden-print")
  $(".#{targetId}").removeClass("hidden-xs-up")
  $(".#{targetId}").removeClass("hidden-print")

hideTarget = (targetId) ->
  $("##{targetId}").addClass("hidden-xs-up")
  $("##{targetId}").addClass("hidden-print")
  $(".#{targetId}").addClass("hidden-xs-up")
  $(".#{targetId}").addClass("hidden-print")

keep_going = () ->
  return false

stop = () ->
  return true

hideAllDetails = (event, $element) ->
  debug("hideAllDetails")
  $(".drill-down-toggle.showing-details").click()

collapseAll = (event, $element) ->
  debug("collapseAll")
  $(".drill-down-toggle.showing-details").click()
  resetControls()

expandAll = (event, $element) ->
  debug("expandAll")
  $(".drill-down-toggle.hiding-details").click()
  resetControls()

alwaysShowHideAllToggle = (event, $element) ->
  debug("alwaysShowHideAllToggle")
  if $('#retrieve_details_on_load').val() == 'false'
    $('#retrieve_details_on_load').val('true')
    $element.text("Always retrieve details").append(" &nbsp;<i class='fa fa-check'></i>")
  else
    $('#retrieve_details_on_load').val('false')
    $element.text("Always retrieve details")

window.showAsExpanded = (targetId) ->
  debug('showAsExpanded')
  $('a.'+targetId).removeClass("no-details").removeClass("hiding-details")
  $('a.'+targetId).addClass("showing-details")
  showTarget(targetId)
  $('a.'+targetId).find('i.fa-caret-right').removeClass('fa-caret-right').addClass('fa-caret-down')

window.showDetailsRetrieved = (targetId) ->
  debug('showDetailsRetrieved')
  $("##{targetId}").addClass('retrieved')

window.resetControls = () ->
  debug('resetControls')
  name_count = $('.name-heading').length
  details_retrieved_count = $('.details.retrieved').length
  expanded_details_count = Math.min(details_retrieved_count, $('a.showing-details').length)
  collapsed_details_count = $('.hiding-details').length
  debug("name_count: #{name_count}")
  debug("details_retrieved_count: #{details_retrieved_count}")
  $('#details-retrieved-count').text("#{details_retrieved_count}")
  debug("expanded_details_count: #{expanded_details_count}")
  debug("collapsed_details_count: #{collapsed_details_count}")
  if name_count == 0
    $('.control').addClass('hidden-xs-up')
  else
    if details_retrieved_count == name_count
      $('#retrieve-details-control').addClass('hidden-xs-up')
    else
      $('#retrieve-details-control').removeClass('hidden-xs-up')
    if expanded_details_count > 0
      $('#expanded-details-count').text("(#{expanded_details_count})")
      $('#collapse-details-control').removeClass('hidden-xs-up')
    else
      $('#collapse-details-control').addClass('hidden-xs-up')
    if collapsed_details_count > 0
      $('#collapsed-details-count').text("(#{collapsed_details_count})")
      $('#expand-details-control').removeClass('hidden-xs-up')
    else
      $('#expand-details-control').addClass('hidden-xs-up')
    if details_retrieved_count > 0 && details_retrieved_count < name_count
      $('#more-details-text').removeClass('hidden-xs-up')
    else
      $('#more-details-text').addClass('hidden-xs-up')


switchNameType = (event, $element) ->
  debug("switchNameType")
  switchTo = $element.data("switch-to")
  $('#name_type').val(switchTo)
  $('.name-type-switch-item').removeClass('active')
  $element.closest('.name-type-switch-item').addClass('active')
  $('#search-button').click()
  event.preventDefault()
  event.stopPropagation()

# Turbolinks
ready = ->
  debug('Start of search.js document ready')
  debug('jQuery version: ' + $().jquery)
  $('body').on('click','.nav-new-search', (event) -> navNewSearch(event,$(this)))
  $('body').on('click','.details-toggle', (event) -> detailsToggle(event,$(this)))
  $('body').on('click','.needs-details-limit', (event) -> needsDetailsLimit(event,$(this)))
  $('body').on('submit','#search-form', (event) -> searchForm(event,$(this)))
  $('body').on('click','.drill-down-toggle', (event) -> drillDownToggle(event,$(this)))
  $('body').on('click','#hide-all-details-link', (event) -> hideAllDetails(event,$(this)))
  $('body').on('click','.retrieve-details-control', (event) -> retrieveDetails(event,$(this)))
  $('body').on('click','.collapse-details-control', (event) -> collapseAll(event,$(this)))
  $('body').on('click','.expand-details-control', (event) -> expandAll(event,$(this)))
  $('body').on('click','#always-retrieve-details-toggle', (event) -> alwaysShowHideAllToggle(event,$(this)))
  $('body').on('click','.name-type-switch-link', (event) -> switchNameType(event,$(this)))
  loadDetailsIfRequired() if typeof(loadDetailsIfRequired) == "function"
  resetControls() if typeof(resetControls) == "function"

$(document).ready(ready)
$(document).on('page:load', ready)

StockSearch =
  searchField: ".stock-lookup.typeahead"
  stocks: null

  init: ->
    console.log "Initialize Stock Search"
    @initBloodhound()
    @listenForQueries()

  initBloodhound: ->
    @stocks = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
      queryTokenizer: Bloodhound.tokenizers.whitespace
      remote: 'stocks/lookup.json?query=%QUERY'
    @stocks.initialize()

  listenForQueries: ->
    $(@searchField).typeahead null,
      name: 'stocks'
      displayKey: 'value'
      # source: @stocks.ttAdapter()
      source: (query, cb) ->
        $.get "stocks/lookup.json?query=#{query}", (data) ->
          console.log data
          cb(data)

$ ->
  StockSearch.init()
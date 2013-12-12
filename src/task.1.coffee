###
  Преобразование query строки в Object
###

arrayParams = /(.*)\[(.*)\]/  # + ассоциативный массив

window.parseQuery = (url) ->
  queryStr = getQuery url.split('?')...

  $res = {}

  queryStr?.split('&').forEach (item) ->
    [key, value] = item.split '='
    if _ = key.match arrayParams
      if _[2] is "" # Это массив ?
        key = _[1]
        $res[key] = [] unless $res[key] instanceof Array
        $res[key].push value

      else # а может это ассоциативный массив
        key = _[1]
        $res[key] = {} unless typeof $res[key] is 'object'
        $res[key][_[2]] = value

    else 
      $res[key] = value
  $res


getQuery = ->
  for item in arguments
    if item.match "=|&"
      return item

###
  Функция расширения url с заданными парамметрами  
###


window.extendUrlByParams = (url, params) ->
  # Восспользуемся нашей функция для парсинга query :)
  paramsFromUrl = $.extend window.parseQuery(url), params
  [clearUrl,] = url.split '?'


  clearUrl + '?' + http_build_query paramsFromUrl


http_build_query = (data) ->
  arg_separator = '&'
  tmp_arr = []
  i = 0

  for key of data
    use_key = encodeURIComponent key
    use_val = encodeURIComponent data[key].toString()
    use_val = use_val.replace /%20/g, '+'

    if !isNaN(key)
      use_key = numeric_prefix + i
    
    tmp_arr[i] = use_key + '=' + use_val
    i++

  tmp_arr.join arg_separator
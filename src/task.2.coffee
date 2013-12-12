
###
  Функция сравнения параметров двух форм
###

window.compareForms = (form1, form2) ->
  form1 = $(form1).serializeArray()
  form2 = $(form2).serializeArray()

  differences = []

  # сначало пробежимся по первой форме посомтрим что изменилось во второй
  for item_in_1, i1 in form1
    for item_in_2, i2 in form2
      if item_in_1?.name is item_in_2?.name

        if item_in_1.value isnt item_in_2.value
          addToDifferences item_in_2.name, item_in_1.value, item_in_2.value, differences
        delete form1[i1]
        delete form2[i2]

  form1 = cleanFromEmptiness form1
  form2 = cleanFromEmptiness form2

  form1?.forEach (param) ->
    # тут у нас все удалённые
    addToDifferences param.name, null, null, differences, 'delete'

  form2?.forEach (param) ->
    # тут у нас будут добавленные
    addToDifferences param.name, null, null, differences, 'insert'
    

  return 'Формы идентичны' if differences.length is 0 
  differences

addToDifferences = (paramName, oldValue, newValue, differences, type = 'update') ->
  differences.push  if type is 'update'
      "Обновился парамметр '#{paramName}': был '#{oldValue}', а стал '#{newValue}'"
    else if type is 'delete'
      "Удалён парамметр '#{paramName}'"
    else if type is 'insert'
      "Добавлен новый парамметр: '#{paramName}'"


# чистим от пустых элементов
cleanFromEmptiness = (array) ->
  array.filter (item) -> item
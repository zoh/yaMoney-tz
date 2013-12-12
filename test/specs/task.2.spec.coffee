
expect = chai.expect

describe 'Spec on compare forms', ->
  form1 = null
  form2 = null

  beforeEach ->

    form1 = $(""" 
        <form>
          <input type=text name="param1" value="test">
        </form> """)
    form2 = $(""" 
        <form>
          <input type=text name="param1" value="test">
        </form> """)

  it 'should answer to equal forms', ->
    expect(compareForms form1, form2).to.eq 'Формы идентичны'

  it 'should answer about update param', ->
    form2.find('[name=param1]').val('new_val')

    expect(compareForms form1, form2).to.eqls ["Обновился парамметр 'param1': был 'test', а стал 'new_val'"]

  it 'should answer delete params', ->
    form1
      .append("<input name=arguments  value='test' />")
      .append("<input name=arguments2  value='test' />")
    
    expect(compareForms form1, form2).to.eqls [
      "Удалён парамметр 'arguments'",
      "Удалён парамметр 'arguments2'"
    ]

  it 'should answer insert params', ->
    form2
      .append("<input name=arguments  value='test' />")

    expect(compareForms form1, form2).to.eqls [
      "Добавлен новый парамметр: 'arguments'"
    ]    
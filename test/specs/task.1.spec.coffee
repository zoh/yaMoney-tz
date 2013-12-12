
describe 'Spec on parser query', ->
  parseQuery = window.parseQuery
  expect = chai.expect

  it 'should parse form url link with query', ->
    link = "http://yandex.ru/index?param=1&param2=123"
    expect(parseQuery link).to.eqls {
      param: '1'
      param2: '123'
    }

  it 'should parse form url link without query', ->
    link = "http://yandex.ru/index"
    expect(parseQuery link).to.be.empty

  it 'should parse from query string', ->
    expect(parseQuery 'test=lol&name=fun').to.be.eqls {
      test: 'lol'
      name: 'fun'
    }

  it 'should parse with array', ->
    expect(parseQuery 'test=lol&args[]=2&args[]=2&args[]=3&args[]=5&args[]=').to.be.eqls {
      test: 'lol'
      args: ['2', '2', '3', '5', '']
    }

  it 'should parse with assoc array', ->
    expect(parseQuery 'test=lol&args[]=2&args[]=2&assoc[param]=34&assoc[param2]=344').to.be.eqls {
      test: 'lol'
      args: ['2', '2']
      assoc:
        param: '34'
        param2: '344' 
    }    
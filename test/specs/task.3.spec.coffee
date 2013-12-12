
expect = chai.expect

describe 'Spec serialize params and extend with url', ->

  it 'should make simple url', ->
    url = 'http://ya.ru/index.html'
    params =
      test: 1
      name: 'lol'

    expect(extendUrlByParams url, params).to.eq 'http://ya.ru/index.html?test=1&name=lol'

  it 'should with extend params from query', ->
    url = 'http://ya.ru/index.html?old_value=test'
    params =
      test: 1
      name: 'lol'

    expect(extendUrlByParams url, params).to.eq 'http://ya.ru/index.html?old_value=test&test=1&name=lol'

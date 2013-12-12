
expect = chai.expect

describe 'Spec on library presentations', ->
  library = null
  $temp = null
  $presentation_list = []

  before ->
    $(document.body).append $temp = $('<div>')

  beforeEach ->
    $presentation_list = [
      new Presentation 'Первая презентация', [
        'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-1-638.jpg?cb=1386772521'
        'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-2-1024.jpg?cb=1386772521'
        'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-6-1024.jpg?cb=1386772521' 
      ]
      new Presentation 'Вторая презентация', [
        'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-6-1024.jpg?cb=1386772521'
        'http://image.slidesharecdn.com/howtobuildamvpappasanon-techfounder-1-131205164335-phpapp02/95/slide-3-1024.jpg?cb=1386771939'
        'http://image.slidesharecdn.com/howtobuildamvpappasanon-techfounder-1-131205164335-phpapp02/95/slide-9-1024.jpg?cb=1386771939'
      ]
      new Presentation 'Третья'
    ]
    library = new Library $temp, $presentation_list
    
  it 'should set sequence init', ->
    for _, i in $presentation_list
      expect(_._id).to.eq i

  it 'get presentation by id', ->
    expect(library.get 1).to.eq $presentation_list[1]


  describe 'render', ->
    beforeEach ->
      library.render()

    it 'should render library in container', ->
      expect($temp.find('.presentation').length).to.eq 3

    it 'should set title presentation', ->
      expect($temp.find('.presentation h4').eq(1).text() ).to.eq 'Вторая презентация'

    it 'should set img cover for presentation', ->
      expect($temp.find('.presentation img').eq(1).attr 'src' )
        .to.eq 'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-6-1024.jpg?cb=1386772521'

    it 'should set count slides in presentation', ->
      expect($temp.find('.presentation .count-slides').eq(1).text() ).to.eq 'Слайдов: 3'

  describe 'switch slides', ->
    present = null

    beforeEach ->
      present = library.get 0

    it 'should get current slide', ->
      slide = present.getCurentSlide()
      expect(slide).to.eqls {
        index: 1 # index for users :)
        img: 'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-1-638.jpg?cb=1386772521'
      }

    it 'should swith on next slide', ->
      present.next().next().next().next() # should switch on #3 slide
      expect(present.getCurentSlide()).to.eqls {
        index: 3 # index for users :)
        img: 'http://image.slidesharecdn.com/10eventtrendsfor2014-131210093316-phpapp01/95/slide-6-1024.jpg?cb=1386772521'
      }

  after ->
    $temp.remove()


describe 'Spec on presentations', ->

  it 'should set id ', ->
    presentation = new Presentation
    presentation.setId 2
    expect(presentation._id).to.eq 2
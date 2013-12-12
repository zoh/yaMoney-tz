
###
  Работа с презентациями
###

present_item_tpl = (_) ->
  """ <div class="col-md-3  presentation">
      <div class="thumbnail" style="height: 267px; cursor: pointer;" data-id="#{_._id}" >
        <h4 style="text-align: center;">#{_.name}</h4>
        <img src="#{_.getCoverImg()}" style="background-color: #ccc; max-height: 200px; max-width: 250px;">
        <p class="count-slides" style="text-align: right; padding-top: 10px;">Слайдов: #{_.countSlides()}</p>
      </div>
    </div> """

present_main_tpl = (_) ->
  """<div class="presentation-container" >
  <section class="slide">
    <img style="height: 100%;" src="#{_.getCurentSlide().img}" />
  </section>
  <footer>
    <div >
      <div class="col-md-3">
        <b>#{_.name}</b>
      </div>

      <div class="col-md-3 col-md-offset-2">
        <button><i class="glyphicon glyphicon-arrow-left prev"></i></button>
        <button><i class="glyphicon glyphicon-arrow-right next"></i></button>
      </div>

      <div class="col-md-2 col-md-offset-2">
        Слайды #{_.getCurentSlide().index} из #{_.countSlides()}
      </div>

    </div>
  </footer>
</div>"""

KEYS =
  ESC: 27
  ARROW_RIGHT: 39
  ARROW_LEFT: 37


# 
class window.Library
  # @container - куда будет рендерится презентации
  # @presentations - массив презентаций
  constructor: (@container, @presentations) ->
    # тут будет текущая выбранная презентация
    @current_presentation = null
    @present_container = null

    _.setId i for _, i in @presentations

    # выбор и открытие презентации
    @container.on 'click', '.presentation > div', @onSelectPresent

    @container.on 'click', '.prev', @onPrevSlide
    @container.on 'click', '.next', @onNextSlide


    $(document).on 'keyup', (e) =>
      keyCode = e.keyCode
      return unless @current_presentation
      if keyCode is KEYS.ESC
        @onCancelPresent()
      else if keyCode is KEYS.ARROW_LEFT
        @onPrevSlide()
      else if keyCode is KEYS.ARROW_RIGHT
        @onNextSlide()
      
  onPrevSlide: =>
    @current_presentation.prev()
    @reRenderWithCurrentPresent()

  onNextSlide: =>
    @current_presentation.next()
    @reRenderWithCurrentPresent()

  reRenderWithCurrentPresent: =>
    @present_container.empty()
    @present_container.html $(present_main_tpl @current_presentation).html()

  # Отмена выбранной презентации
  onCancelPresent:  =>
    if confirm 'Вы действительно хотите закрыть презентацию?'
      @current_presentation = null
      @present_container.remove()
      @present_container = null
    

  onSelectPresent: (e) =>
      presentId = e.currentTarget.dataset.id
      present = @get presentId
      if present.slides.length is 0
        alert('В данной презентации нет слайдов для показа');
        return

      @current_presentation = present
      @present_container = $ present_main_tpl present
      @container.append  @present_container

  get: (i) ->
    @presentations[i]

  render: ->
    $row = $ '<div class=row></div>'

    for _ in @presentations
      $row.append present_item_tpl _

    @container.html $row


# Класс презентации
class window.Presentation
  
  # @name - наименование презентации
  # @slides - массив с картинками
  constructor: (@name, @slides = []) ->
    @_id = null
    @_current_slide = 0

  # Полуаем информацию о текущес слайде
  getCurentSlide: ->
    index: @_current_slide + 1
    img: @slides[@_current_slide]

  next: ->
    if @_current_slide < @slides.length - 1
      @_current_slide++
    @

  prev: ->
    if @_current_slide > 0
      @_current_slide--
    @

  getCoverImg: ->
    @slides?[0] || ''

  countSlides: ->
    @slides?.length || 0

  setId: (@_id) ->
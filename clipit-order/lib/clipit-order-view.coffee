module.exports =
class ClipitOrderView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('clipit-order')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The ClipitOrder package is Alive!"
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Add a word count function
  setCount: (count)->
    displayText = "There are #{count} words."
    @element.children[0].textContent = displayText

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

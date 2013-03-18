# Last array element
Array::last = () ->
  this[this.length - 1]

# Capitalize string
String::capitalize = ->
  @substr(0, 1).toUpperCase() + @substr(1)

# Prototype magic for n.times
Number::times = (fn) ->
  do fn for [1..@valueOf()]
  return

class D.Util
  @randomInt: (lower, upper=0) ->
    start = Math.random()
    if not lower?
      [lower, upper] = [0, lower]
    if lower > upper
      [lower, upper] = [upper, lower]
    Math.floor(start *  (upper - lower + 1) + lower)

# window.requestAnimationFrame polyfill
do ->
    w = window

    for vendor in ['ms', 'moz', 'webkit', 'o']
        break if w.requestAnimationFrame
        w.requestAnimationFrame = w["#{vendor}RequestAnimationFrame"]
        w.cancelAnimationFrame = (w["#{vendor}CancelAnimationFrame"] or
                                  w["#{vendor}CancelRequestAnimationFrame"])

    # deal with the case where rAF is built in but cAF is not.
    if w.requestAnimationFrame
        return if w.cancelAnimationFrame
        browserRaf = w.requestAnimationFrame
        canceled = {}
        w.requestAnimationFrame = (callback) ->
            id = browserRaf (time) ->
                if id of canceled then delete canceled[id]
                else callback time
        w.cancelAnimationFrame = (id) -> canceled[id] = true

    # handle legacy browsers which don’t implement rAF
    else
        targetTime = 0
        w.requestAnimationFrame = (callback) ->
            targetTime = Math.max targetTime + 16, currentTime = +new Date
            w.setTimeout (-> callback +new Date), targetTime - currentTime

        w.cancelAnimationFrame = (id) -> clearTimeout id


# addEventListener polyfill
((win, doc) ->
  if win.addEventListener
    return

  docHijack = (p) ->
    old = doc[p]
    doc[p] = (v) ->
      addListen(v)

  addEvent = (_on, fn, self) ->
    (self = this).attachEvent "on#{_on}", (e) ->
      e = e || win.event
      e.preventDefault = e.preventDefault || (() -> e.returnValue = false)
      e.stopPropagation = e.stopPropagation || (() -> e.cancelBubble = true)
      fn.call self, e

  addListen = (obj, i) ->
    if i = obj.length
      while i--
        obj[i].addEventListener = addEvent
    else
      obj.addEventListener = addEvent
    obj

  addListen([doc, win])

  if ('Element' in win)
    win.Element::addEventListener = addEvent
  else
    doc.attachEvent 'onreadystatechange', () ->
      addListen(doc.all)
    docHijack('getElementsByTagName')
    docHijack('getElementById')
    docHijack('createElement')
    addListen(doc.all)

)(window, document)

# Logging
console.log = ->
C = {
  info: (msg) ->
    console.info(msg)
}
window.C = C
class Observer

    bind : (event, fn) ->
        this._events ||= {}
        this._events[event] ||= []
        this._events[event].push(fn)

    unbind: (event, fn) ->
        @_events ||= {}

        if @_events[event]
            @_events[event].splice(@_events[event].indexOf(fn), 1)

    trigger: (event, args...) ->
        @_events ||= {}

        if @_events[event]
            for callback in @_events[event]
                callback.apply(this, args)

namespace 'camfire', (exports) ->
  exports.app.service 'utilService', ($rootScope) ->
    {
      wrapMessage:  (type, data, skipDataStringify = false) ->
        data = if skipDataStringify then data else $.stringifyJSON(data)
        $.stringifyJSON
          type: type
          data: data

      indexItem: (object, item, index)->
        object[item[index]] = item

      moveById: (src, dest, id) ->
        if src[id] == undefined
          throw new Error("Illegal Argument")
        dest[id] = src[id]
        delete src[id]

      moveBySafeKey: (src, dest, key) ->
        @moveById(src, dest, @safeKey(key))

      parseSignal: (json) ->
        json = @parseJson(json)
        json.data = @parseJson(json.data)
        json

      parseJson: (msg) ->
        try
          json = jQuery.parseJSON(msg)
        catch e
          debug.warn "This doesn't look like a valid JSON: ", msg
          throw e
        json

      # Gets the number of elements in an object
      size: (object) ->
        Object.keys(object).length

      # This is needed because the salted and hashed session ids start with a dollar sign. Angular's binding will
      # ignore these dollar sign prefixed keys. It will cause the view to not update as expected.
      safeKey:  (key) ->
        key.substring(1)

      safeIndexedInsert: (object, indexAttr, value) ->
        id = @safeKey(value[indexAttr])
        object[id] = value

      getByKeySafely: (object, index)->
        object[@safeKey(index)]

      safeSessionIdHashInsert: (object, value) ->
        @safeIndexedInsert(object, 'sessionIdHash', value)


    }



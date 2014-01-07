define(['namespace', 'app'], ->
  namespace 'camfire', (exports) ->
    class exports.RemoteMediaService
      constructor: (@$rootScope, @utilService, @peerConnectionService, @socketService, @localMediaService) ->

      remoteStream: null
      remoteStreams: []

      availableStreamInfos: []
      connectingStreamInfos: []
      subscribedStreamInfos: {}

      areStreams: () ->
        @utilService.size(@availableStreamInfos) || @utilService.size(@connectingStreamInfos) || @utilService.size(@subscribedStreamInfos)

      addAvailableStreamInfo: (data) ->
        debug.debug "Making stream available [#{data.label}]..."
        @availableStreamInfos.push(data)

      removeAvailableStreamInfo: (data) ->
        debug.debug "Removing stream available [#{data.label}]..."
        console.log(data)
        @availableStreamInfos = @availableStreamInfos.filter (x) -> x.label != data.label

      setAvailableStreamInfos: (data) ->
        debug.debug "Setting all available streams"
        @availableStreamInfos = data

      removeStreamInfo: (data) ->
        id = data['sessionIdHash']
        debug.debug "Removing stream[#{id}]..."
        delete @availableStreamInfos[id.substring(1)]

      subscribe: (label) ->
        debug.debug "Subscribing to stream [#{label}]..."
        streamInfo = @availableStreamInfos.filter (x) -> x.label == label
        @connectingStreamInfos.push(streamInfo[0])
        @socketService.emitWrapped "signal", "subscribe", label, true

      stop: ->
  #        debug.debug "Stopping remote media..."
        debug.error "Method not implemented!"

      # These methods should not be called directly. They are meant to define callback behavior.
      onAddStream: (mediaStreamEvent) =>
        debug.debug "onaddstream callback has been made..."
        debug.debug mediaStreamEvent
        stream = mediaStreamEvent.stream
        sessionIdHash = stream.id
        @utilService.getByKeySafely(@connectingStreamInfos, sessionIdHash)['stream'] = stream
        @utilService.moveBySafeKey(@connectingStreamInfos, @subscribedStreamInfos, sessionIdHash)
        @$rootScope.$apply()

      onRemoveStream: (mediaStreamEvent) =>
        debug.debug "onremovestream callback has been made..."
        debug.error 'onremovestream needs to be implemented!'
        @$rootScope.$apply()

    exports.app.service 'remoteMediaService', camfire.RemoteMediaService
)

namespace 'camfire', (exports) ->
  class exports.SignalService
    constructor: (@$rootScope,
                  @configurationService,
                  @socketService,
                  @utilService,
                  @peerConnectionService,
                  @localMediaService,
                  @remoteMediaService) ->

    init: ->
      debug.debug("Initializing signal service...")
      @socketService.request.onMessage = (rs) =>
        debug.debug(rs.responseBody)
        @$rootScope.$apply =>
          @signal(rs.responseBody)

    signal: (msg) =>
      debug.debug("Attempting to parse signal: " + msg)
      json = @utilService.parseSignal(msg)
      debug.info "'" + json.type + "'" + " signal received..."
      if json.type is "candidate"
        debug.debug "Creating ICE candidate from server..."
        iceCandidate = new RTCIceCandidate(json.data)
        debug.debug "Adding ICE candidate from server to peer connection..."
        @peerConnectionService.addIceCandidate iceCandidate
      else if json.type is "answer"
        debug.debug "Creating remote description..."
        remoteDescription = new RTCSessionDescription(json.data)
        debug.debug "Setting remote description..."
        debug.debug remoteDescription
        @peerConnectionService.setRemoteDescription remoteDescription
      else if json.type is "offer"
        # TODO: The first part is exactly the same as the answer block, make it DRY
        debug.debug "Creating remote description..."
        remoteDescription = new RTCSessionDescription(json.data)
        @peerConnectionService.setRemoteDescription remoteDescription
      else if json.type is "offer"
        @peerConnectionService.createAnswer(@configurationService.sdpConstraints)
      else if (json.type is "new-stream")
        debug.debug("Adding new stream info...")
        @remoteMediaService.addAvailableStreamInfo(json.data)
      else if (json.type is "remove-stream")
        debug.debug("Removing stream info...")
        debug.debug(json.data)
        @remoteMediaService.removeStreamInfo(json.data)
      else if (json.type is "session-id-hash")
        debug.debug json.data
        @localMediaService.sessionIdHash = json.data
      else
        # Unknown message
        debug.error "Invalid message!"

  exports.app.service 'signalService', camfire.SignalService

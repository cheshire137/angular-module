namespace 'camfire', (exports) ->
  # Container for webrtc peerconnection
  class exports.PeerConnectionService
    constructor: (@$rootScope, @socketService) ->

    localPeerConnection: null

    # Factory method that creates underlying RTCPeerConnection. Allows us to overrride for testing.
    newPeerConnection: (configuration) ->
      debug.debug "Attempting to create local PeerConnection..."
      new RTCPeerConnection(configuration)

    createPeerConnection: (configuration) ->
      @localPeerConnection = @newPeerConnection(configuration)
      @setOnIceCandidate(@onIceCandidate)

    # Delegate callback methods.
    setOnIceCandidate: (callback) ->
      @localPeerConnection.onicecandidate = callback

    setOnAddStream: (callback)->
      @localPeerConnection.onaddstream = callback

    setOnRemoveStream: (callback) ->
      @localPeerConnection.onremovestream = callback

    addIceCandidate: (iceCandidate) ->
      @localPeerConnection.addIceCandidate iceCandidate

    setRemoteDescription: (remoteDescription) ->
      @localPeerConnection.setRemoteDescription remoteDescription

    createOffer: (sdpConstraints) ->
      success = (desc) =>
        debug.debug "Offer created, Setting local description..."
        @localPeerConnection.setLocalDescription desc
        @sendOffer(desc)

      failure = =>
        debug.error 'Failed to create offer!'

      debug.debug "Attempting to create offer..."
      @localPeerConnection.createOffer success, failure, sdpConstraints

    sendOffer: (desc) ->
      @socketService.emitWrapped "signal", "offer", desc

    createAnswer: (sdpConstraints) ->
      debug.debug "Attempting to create answer..."
      success = (desc) =>
        debug.debug "Answer successfully created, setting local description..."
        @localPeerConnection.setLocalDescription desc
        @sendAnswer(desc)
      failure = =>
        debug.error 'Failed to create answer!'

      @localPeerConnection.createAnswer success, failure, sdpConstraints

    sendAnswer: (desc) ->
      @socketService.emitWrapped "signal", "answer", desc

    close: ->
      # TODO: Figure out how to end call correctly. Need to be able to stop camera as well as end broadcast!
      debug.debug "Closing local media..."
      @localPeerConnection.close()
      @localPeerConnection = null

    # This method should not be called directly. It defines callback behavior.
    onIceCandidate: (event) =>
      debug.debug "onicecanidate called..."
      if event.candidate
        @socketService.emitWrapped "signal", "candidate", event.candidate
      else
        debug.debug "End of candidates"

    stopLocalStreamAndBroadcast: (stream) ->
      debug.debug "Removing local stream..."
      @removeStream(stream)
      stream.stop()

    removeStream: (stream) ->
      debug.debug "Stopping local stream broadcast..."
      @localPeerConnection.removeStream stream
      # This handler does not seem to be getting called for now we will call it manually.
      @localPeerConnection.onremovestream null

    addStream: (stream) ->
      debug.debug "Adding stream to peer connection"
      @localPeerConnection.addStream stream

  exports.app.service 'peerConnectionService', camfire.PeerConnectionService

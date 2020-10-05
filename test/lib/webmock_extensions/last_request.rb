# frozen_string_literal: true

module LastRequest
  def last_request
    @last_request
  end

  def last_request=(request_signature)
    @last_request = request_signature
  end
end

WebMock.extend(LastRequest)
WebMock.after_request do |request_signature, _response|
  WebMock.last_request = request_signature
end

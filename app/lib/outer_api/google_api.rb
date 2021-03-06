class OuterApi::GoogleApi
  HTTP_REQ = OuterApi::HttpRequest.new
  def place_search_exec(query)
    uri = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
    OuterApi::GoogleApi::HTTP_REQ.send_request(uri, query)
  end

  def place_detail_exec(query)
    uri = 'https://maps.googleapis.com/maps/api/place/details/json'
    OuterApi::GoogleApi::HTTP_REQ.send_request(uri, query)
  end

  def distance_matrix_exec(query)
    uri = 'https://maps.googleapis.com/maps/api/distancematrix/json'
    OuterApi::GoogleApi::HTTP_REQ.send_request(uri, query)
  end

  def google_map_exec(query)
    uri = 'https://maps.googleapis.com/maps/api/geocode/json'
    OuterApi::GoogleApi::HTTP_REQ.send_request(uri, query)
  end
end

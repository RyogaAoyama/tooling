class OuterApi::HttpRequest
  def send_request(uri, params)
    # リクエストの設定
    query = params.to_query
    uri = URI.parse("#{ uri }?#{ query }")

    # リクエスト作成
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.get(uri)
    end

    case res
    when Net::HTTPSuccess
      result = JSON.parse(res.body)
      # Rails.logger.info("URL -> #{ uri }")
      [true, 200, result]
    when Net::HTTPRedirection
    when Net::HTTPClientError
      raise Net::HTTPServerException
    when Net::HTTPServerError
      raise Net::HTTPFatalError
    end
  rescue Net::HTTPServerException => e
    Rails.logger.error(e.message)
    [false, 400, nil]
  rescue Net::HTTPServerError => e
    Rails.logger.error(e.message)
    [false, 500, nil]
  rescue JSON::ParserError => e
    Rails.logger.error(e.message)
    Rails.logger.error('There is no json format!')
    [false, 400, nil]
  rescue TimeoutError => e
    Rails.logger.error(e.message)
    [false, 504, nil]
  end
end

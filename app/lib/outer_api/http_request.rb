class OuterApi::HttpRequest
  def send_request(uri, params)
    begin
      # リクエストの設定
      query = params.to_query
      uri = URI.parse("#{uri}?#{query}")

      # リクエスト作成
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.get(uri)
      end

      case res
      when Net::HTTPSuccess
        result = JSON.parse(res.body)
        return true, 200, result
      when Net::HTTPRedirection
        logger.dubug("必要になったら書きまうす")
      when Net::HTTPClientError
        raise Net::HTTPServerException
      when Net::HTTPServerError
        raise Net::HTTPFatalError
      end

    rescue Net::HTTPServerException => e
      logger.error(e.message)
      return false, 400, nil
    rescue Net::HTTPServerError => e
      logger.error(e.message)
      return false, 500, nil
    rescue JSON::ParserError => e
      logger.error(e.message)
      logger.error("There is no json format!")
      return false, 400, nil
    rescue TimeoutError => e
      logger.error(e.message)
      return false, 504, nil
    end
  end
end
class ErrorDefine
  ERROR_PARAMS = {
    4221 => { code: '4221', message: 'Validation failed', description: 'URL is incorrect' },
    4222 => { code: '4221', message: 'Validation failed', description: 'Validation failed or failed' },
    404 => { code: '404', message: 'page not found', description: 'To a nonexistent page' }
  }.freeze
  def get_error_params(code)
    ErrorDefine::ERROR_PARAMS[code]
  end
end

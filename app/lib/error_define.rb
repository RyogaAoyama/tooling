class ErrorDefine
  ERROR_PARAMS = {
    4221 => { code: '4221', message: 'Validation failed', description: 'URL is incorrect' },
    4222 => { code: '4221', message: 'Validation failed', description: 'Validation failed or failed' }
  }
  def get_error_params(code)
    ErrorDefine::ERROR_PARAMS[code]
  end
  
end
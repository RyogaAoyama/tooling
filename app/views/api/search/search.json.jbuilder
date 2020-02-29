json.set! :result do
  json.extract! @result, *FieldDefine::SEARCH_RESULT_FIELDS
end

json.set! :user do
  json.extract @user, *@town.attribute_names
end

json.set! :result, @result
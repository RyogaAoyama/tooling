json.set! :user do
  json.extract! @user, *@user.attribute_names
end

json.set! :errors do
  json.merge! @errors
end

json.set! :result, @result
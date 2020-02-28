json.set! :user do
  json.extract! @user, *@user.output_column
end

json.set! :errors, @errors

json.set! :result, @result

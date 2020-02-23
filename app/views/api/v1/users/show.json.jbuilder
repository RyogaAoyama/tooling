json.set! :user do
  json.extract! @user, *@user.output_column
end

json.set! :result, @result
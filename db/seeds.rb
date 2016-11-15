password = 'pass123'

1.upto(5) do |i|
  User.create(
    email: "pes-#{i}@woof.com",
    password: password,
    password_confirmation: password
  )
end

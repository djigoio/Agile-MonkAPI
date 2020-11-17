10.times do
  User.create ({
    email: Faker::Internet.email,
    password: Faker::Internet.password
  })

  Customer.create ({
    name: Faker::JapaneseMedia::Doraemon.character,
    surname: Faker::Creature::Horse.name,
    created_by: User.find(1).email
  })
end

#Test administrator user 
User.create ({
  email: 'test@monkey.com',
  password: 'Aa123456',
  is_admin: true
})
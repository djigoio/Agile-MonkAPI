10.times do
10.times do
    User.create ({
        email: Faker::Internet.email,
        password: Faker::Internet.password
    })

    Customer.create ({
        name: Faker::JapaneseMedia::Doraemon.character,
        surname: Faker::Creature::Horse.name,
        created_by: User.find(User.pluck(:id).sample).email
    })
    end
end
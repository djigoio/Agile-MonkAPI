# MonkAPI
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)

MonkAPI is an API made for a company test, where you can authenticate as a user and CRUD other users as an admin or CRUD other customers.

## Installation

1. Clone the project [Ruby 2.5.5 | Rails 6.0.2]
2. Run bundle
```bash
bundle install
```
3. Run pending migrations and seed the DB
```bash
rails db:migrate db:seed
```
4. Run the server and test with postman at localhost:3000
```bash
rails s
```
You may need a secret in your`.env` file so Devise JWT can generate tokens for your API. If so, please add the `.env` file to the root of your project and add `DEVISE_JWT_SECRET_KEY=STRING` where STRING is a secret key you can get by writing `rake secret` on your rails console.

## API Interaction
To interact with the API once the project is set-up, run Postman or any other similar software, and follow the instructions written in our wiki. A sample user is there in case you need it!

Some sample URLs to work with are:

- URL/signup - POST
- URL/login - POST
- URL/v1/users - GET/POST/PUT/DELETE
- URL/v1/customers - GET/POST/PUT/DELETE

## Contributing
Pull requests are discouraged, taken in mind that this is just a project that will never be continued. :)

## License
[MIT](https://choosealicense.com/licenses/mit/)
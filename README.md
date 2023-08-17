# Property Service Api

## Prerequisites

Make sure you have the following software installed on your machine:

- Ruby (version X.X.X)
- Ruby on Rails (version X.X.X)
- Bundler
- PostgreSQL

## Project setup
Clone this repo

```

cd into project directory and check your ruby version:
```
ruby -v
```

### Install the required gems using Bundler:
Using Bundle
```
bundle install
```

### Set up the PostgreSQL database:
```
rails db:create
rails db:migrate
```

### Start the Rails server:
```
rails server
```

### Additional Configuration

Modify the database configuration in config/database.yml to match your PostgreSQL credentials.
Modify the spec/swagger_helper.rb and swagger/v1/swagger.yaml files to match your localhost listening port
Customize the project settings, such as routes, views, and models, based on your requirements.


### Customize configuration
See [Configuration Reference](https://guides.rubyonrails.org/).

## Credits
- Babatunde Oladejo [Sulaymantaofiq@gmail.com](mailto:sulaymantaofiq@gmail.com)

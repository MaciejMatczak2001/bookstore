## Technologies
* Ruby version: 2.7.2
* Rails version: 6.1.3
* Docker version: 24.0.6

## Clone the repository:
```
$ git clone git@github.com:MaciejMatczak2001/bookstore.git
```
## Run docker
```
$ docker compose build bookstore
$ docker compose up
```

## Populate the data base with initial data
```
$ rails db:seed
```

## Test the app
```
$ rspec
```

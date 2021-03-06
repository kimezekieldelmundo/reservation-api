# RESERVATION API
## Setup
### System dependencies
- ruby 2.6.3p62
- rails 6.0.4
- yarn 1.22.10
- node v14.17.1
- mysql  Ver 14.14

### Database
#### Development
1. if the database to be used does not exist:
```
[reservation-api] rake db:create
```
2. load schema
```
[reservation-api] rake db:schema:load
```
Config | value | default value
--- | --- | ---
database | ENV['DB_NAME'] | 'reservation_api'
username | ENV['DB_USER'] | 'root'
password | ENV['DB_PASSWORD'] | ''
host | ENV['DB_HOST'] | 'localhost'
pool | ENV['DB_POOL'] | '5'
#### Testing
1. if the database to be used does not exist:
```
[reservation-api] RAILS_ENV=test rake db:create
```
Config | value | default value
--- | --- | ---
database | ENV['DB_NAME'] | 'reservation_api_test'
username | ENV['DB_USER'] | 'root'
password | ENV['DB_PASSWORD'] | ''
host | ENV['DB_HOST'] | 'localhost'
pool | ENV['DB_POOL'] | '5'
## Running the server
To run the server, run: 
```
[reservation-api] rails server
```
check at: localhost:3000
### Implemented endpoints
METHOD | endpoint | params | description
--- | --- | --- | ---
GET | /reservations/:id | none | get a Reservation in json format given the id
POST | /reservations/import | reservation data | import a reservation given reservation data
GET | /guests/:id | none | get a Guest in json format given the id

### Sample Reservation import using cURL
```
curl --location --request POST 'localhost:3000/reservations/import' \
--header 'Content-Type: application/json' \
--data-raw '{
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
        },
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00"
    }'
```
## Tests
To execute tests, run:
```
[reservation-api] rake db:test:prepare
[reservation-api] rails test --verbose
```
## Notes
- for the two payload format provided, it is assumed that all the fields for each format will be provided
- Reservation validations
    - start_date should be on or before end_date
    - guests is the total of adults + children + infants
- Guest Validations
    - email is unique
- if the guest id provided in the reservation data does not exists, the Guest will be created using the guest details supplied
- if the guest id provided in th reservation data exists, the Guest will be updated using the guest details supplied unless there are validation errors e.g. guest email already exists

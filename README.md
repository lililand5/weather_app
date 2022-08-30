# README
In this application, you can get weather data in the city

## Endpoints

| Endpoint | Description |
| ------ | ------ |
| /weather/current | Current temperature|
| /weather/historical | Hourly temperature for the last 24 hours |
| /weather/historical/max | Maximum temperature in 24 hours |
| /weather/historical/min | Minimum temperature in 24 hours |
| /weather/historical/avg | Average temperature over 24 hours |
| /weather/by_time | Find the temperature closest to the passed time |
| /health | Backend status |


## Application Deployment
Create a .env file in the root of the project. Fill in the following data(example)
- DATABASE_USERNAME=postgres
- DEVELOPMENT_DATABASE=weather_db
- TEST_DATABASE=test_weather_db
- PRODUCTION_DATABASE=production_weather_db

### Sidekiq
In order to get the starting temperature is used sidekiq
To use tasks you need to install redis-server
```sh
apt-get install redis-server
```
and run
```sh
bundle exec sidekiq
```

### To see the documentation follow the path
/api-docs

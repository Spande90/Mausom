# Mausom

Mauson is an created in swift 5 for Xcode 

## Build and Runtime Requirements
+ Xcode 11.0 or later
+ iOS 13.6 or later
+ Swift 5
+ MapKit

## API

Use of  [weatherstack](https://weatherstack.com) API using free membership. one can sign in from [here](https://weatherstack.com/signup/free).
generate API token and use it to call a restful web service provided.


```php
http://api.weatherstack.com/current?access_key=[YOUR_ACCESS_KEY]&query=20.3893,72.9106&units=f
```

## Usage
Insert the [YOUR_ACCESS_KEY]() generated, There are different kinds of query provided, one can see the documentation details from [here](https://weatherstack.com/documentation)

* **Sample Call:**

  ```javascript
    https://api.weatherstack.com/current
    ? access_key = YOUR_ACCESS_KEY
    & query = New York
    & units = m
  ```
* **URL**

  /current

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**


    access_key = YOUR_ACCESS_KEY
    
    query = LATITUDE,LONGITUDE
    
*  **Optional**

    units = m

By default, the API will return all results in metric units. Aside from metric units, other common unit formats are supported as well. to demonstrate I have also used Fahrenheit scale.

**Response**
```json
{
    "request": {
        "type": "LatLon",
        "query": "Lat 40.71 and Lon 74.01",
        "language": "en",
        "unit": "f"
    },
    "location": {
        "name": "Karatash",
        "country": "Kyrghyzstan",
        "region": "Osh",
        "lat": "40.550",
        "lon": "74.000",
        "timezone_id": "Asia/Bishkek",
        "localtime": "2020-09-12 02:59",
        "localtime_epoch": 1599879540,
        "utc_offset": "6.0"
    },
    "current": {
        "observation_time": "08:59 PM",
        "temperature": 39,
        "weather_code": 116,
        "weather_icons": [
            "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
        ],
        "weather_descriptions": [
            "Partly cloudy"
        ],
        "wind_speed": 4,
        "wind_degree": 186,
        "wind_dir": "S",
        "pressure": 1019,
        "precip": 0,
        "humidity": 58,
        "cloudcover": 3,
        "feelslike": 36,
        "uv_index": 1,
        "visibility": 6,
        "is_day": "no"
    }
}

```



## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

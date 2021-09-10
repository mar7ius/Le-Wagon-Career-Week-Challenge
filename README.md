# Mercedes Challenge
This is a challenge done during the Career Week of [Le Wagon](https://www.lewagon.org), a 9 weeks coding bootcamp.

The aims was to get used to technical challenges with a real-life exemple.

## Brief
Build a Ruby on Rails application providing an endpoint which takes a GPS latitude and longitude and spits out the names of museums around that location grouped by their postcode as JSON

*FYI : Mapbox provides a handy API endpoint for fetching museums around a location*

As an example when doing a request to `/museums?lat=52.494857&lng=13.437641` would generate a response similar to:

```json
{
  "10999": ["Werkbundarchiv – museum of things"],
  "12043": ["Museum im Böhmischen Dorf"],
  "10179": [
    "Märkisches Museum",
    "Museum Kindheit und Jugend",
    "Historischer Hafen Berlin"
],
  "12435": ["Archenhold Observatory"]
}
```

## Test this code

If you want to run this project by yourself here's what you need:

1. Fork this project
2. Create a free account on [Mapbox](https://www.mapbox.com) for getting an API key
3. Create an .env file at the root of the project, and add this line : `MAPBOX_API_KEY=pk.eyJ1Ijoi*********************` ( remplace the `pk.eyJ1Ijoi********************` part with your API key )
4. Open your terminal and go to the project folder `cd /path/to/folder/project`
5. then `bundle install` and `yarn install`
6. Now you should be able to run this rails app by enter `rails s` to your terminal
7. Test with Postman or directly in your browser. Ex: `http://localhost:3000/api/v1/museums?lat=48.864716&lng=2.349014` to retrieved museums in Paris
8. Enjoy ! 




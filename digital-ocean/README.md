# Deploy Overpass API to droplet

## Usage

```bash
brew bundle
bundle install

# setup digital ocean CLI access
# get token from https://cloud.digitalocean.com/account/api/tokens
export DIGITAL_OCEAN_API_KEY=""

# create the droplet
rake droplet:create

# deploy resources on to the droplet
rake droplet:deploy
```

## Links

- [US region data](https://download.geofabrik.de/north-america/us.html)
- [Overpass API Installation](https://wiki.openstreetmap.org/wiki/Overpass_API/Installation)
- [Nominatim](https://nominatim.openstreetmap.org/ui/search.html)
- [OverpassQL](https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL)
- [Overpass API by Example](https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_API_by_Example)

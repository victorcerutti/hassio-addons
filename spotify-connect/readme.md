Spotify connect Hass.io add-on
--------------------------

This add-on runs librespot on your Hass.io Raspberry Pi.

When running, you'll be able to connect to it directly from the Spotify App.

This add-on can run several instances of Spotify, here is the configuration for each instance :

##### `discovery_mode` (bool)

If set to `true`, Spotify connect will be enable to all device on the same local network.  
If you have friends at home they will be able to play their music too.

If set to `false`, the addon will use your Spotify username and password to connect.  
You will also be able to connect and control playback with Spotify without being on the same network.  
No guests will see the device and won't be able to connect

##### `spotify_user` and `spotify_password` (string)

Your Spotify account informations. `spotify_user` can be either your email or your username.  
If `discovery_mode` is enabled you don't need to set this values.

##### `device_name` (string)

This is the name that will be displayed in Spotify.  
Default is 'Home Assistant'

##### `speaker` (string)

Each instance can be configured to ouput to the correct device.  
Standard configurations are :
- `hw:0,1` for HDMI ouput (default)
- `hw:0,0` for the jack ouput

If you have a different configuration or want to use and USB sound card, have a look at the logs to get the correct numbers.


### Complete exemple

This a working configuration example.

```json
{
  "instances": [
    {
      "discovery_mode": true,
      "device_name": "Home assistant"
    },
    {
      "discovery_mode": false,
      "spotify_user": "my_username",
      "spotify_password": "secret_password",
      "device_name": "My music box"
    }
  ]
}
```

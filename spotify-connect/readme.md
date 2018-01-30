Spotify connect Hass.io add-on
--------------------------

This add-on runs librespot on your Hass.io Raspberry Pi.

When running, you'll be able to connect to it directly from the Spotify App.

This add-on can run several instances of Spotify, here is the configuration for each instance :

##### `device_name` (string)

This is the name that will be displayed in Spotify.  
This is the only required configuration option.  
Default is 'Home Assistant'.

##### `spotify_user` and `spotify_password` (string)

Your Spotify account informations. `spotify_user` can be either your email or your username.  
Setting your identifiers is optional.  
If you don't you won't be able to connect remotely to your instance, only via local network.


##### `allow_guets` (bool)

Default is `true`. Spotify connect will be allow discovery to all devices on the same local network. If you have friends at home they will be able to play their music too.  
If set to `false`, the addon needs your Spotify username and password to connect. The device won't be discoverable on the local network and you will be the only one seeing it.


##### `speaker` (string)

Each instance can be configured to ouput to the correct device.  
Standard configurations are :
- `hw:0,1` for HDMI ouput (default)
- `hw:0,0` for the jack ouput

If you have a different configuration or want to use and USB sound card, have a look at the logs to get the correct numbers.

##### `bitrate` (int)

Quality bitrate of songs played. Can be 96, 160 or 320. Defaults to 160.

##### `initial_volume` (int)

Set the initial volume in % once connected. Defaults is 80.


### Complete exemple

This a the simplest yet working configuration example.  
One instance will be running, available to everyone on the local network.

```json
{
  "instances": [
    {
      "device_name": "Home assistant"
    }
  ]
}
```

This is a more complete exemple, having 2 instances running. One is only visible to me and the other is for guests.

```json
{
  "instances": [
    {
      "device_name": "Home Assistant",
      "spotify_user": "my_username",
      "spotify_password": "my_secret_password",
      "initial_volume": 90,
      "bitrate": 320,
      "allow_guests": false
    },
    {
      "device_name": "Guest music",
      "initial_volume": 50
    }
  ]
}
```

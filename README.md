# Chill-Conky-Theme
New original theme for Conky

Credit to igorw765 (https://github.com/igorw765) for the Spotify scripts. Credit to Closebox73 for weather scripts and a general inspiration of mine. This theme displays system information, current weather, Gmail inbox, Spotify information and has CalCurse support.

# Requirements
- Conky (obviously)
- Cairo
- Playerctl
- Jq
- ffmpeg
- Sed (formatting)
- CalCurse (calendar)
- Git (for cloning this repo)
-Conky Manager → ```sudo add-apt-repository ppa:teejee2008/foss``` ```sudo apt update sudo apt install conky-manager2```

# Installation
1. Install the required dependencies if they aren't already installed

```sudo apt-get install conky calcurse jq cairo ffmpeg playerctl sed git```

2. Go to your Conky directory and clone the repo

```cd ~/.config/conky/```
```git clone https://github.com/Commander-ShepardN7/Chill-Conky-Theme.git```

3. Play with the ```offset```, ```voffset``` variables.

4. Start the themes using Conky Manager

# Setting preferences and widgets

You'll need to manually set some stuff

- Chill (Main theme)
1. Weather and forecast: grab your OpenWeather CityID and API Key and paste them in the  ```weather-v2.o.sh``` file

-Chill Music
1. Local music thumbnail: if you have local music, then paste each of your saved albums' album cover and rename them accordingly ```Name_of_the_Album```. It is case sensitive, and blanks must be separated by underscores.
2. Spotify Flatpak: if you're using a flatpak version of Spotify, be sure to use Flatseal to enable D-bus session and system buses, or else it will lag the theme atrociously

- Chill Mail
1. Gmail:Go to https://support.google.com/accounts/answer/185833?hl=en and follow instructions (you'll ned to enable 2-step verification on your Google account). Copy the 16-digit password (delete blank spaces), go to the ```gmail.sh``` file and replace with your credentials

- Chill Cal and App (appointments)
1. You need calcurse, as metioned above, to use this

# Tested Enviroment
This theme was made on Pop!_OS 22.04 using GNOME 42.9. 

# Screenshot
<img width="1918" height="1077" alt="chilltheme" src="https://github.com/user-attachments/assets/72228da3-a8fc-4c84-b159-8d6cfc1f69bd" />

# Loopy NGINX Stats Monitor

![Loopy NGINX Stats Monitor](./nginx_stats_monitor.png)
  
Latest release available [here](https://github.com/loopy750/NGINX-Stats-Monitor/releases/latest).

This is a program to assist with "IRL streaming" for popular streaming websites such as Twitch, using OBS Studio. This program is currently in use by Twitch streamers and has been proven to a be a valuable asset to their stream.

Using a "homemade" solution to RTMP stream from your location back to your home PC, this program will automatically switch to a "fallback" OBS scene whenever your connection is lost, and is restored when your connection resumes.

Basic features (**_MultiCameraSwitch=false_**) allow a simple two-scene scenario, either "LIVE" or "FALLBACK" scene.

Advanced features (**_MultiCameraSwitch=true_**) consider for a two-camera multiple-scene scenario, and can alternate between scenes depending on the combination of cameras/streams used, i.e. stream 1, stream 2, and both stream 1&2 simultaneously. See 'readme.txt' for a full description regarding these and other settings.
  
  
  
  [Example of program being used in a live stream](https://user-images.githubusercontent.com/35911135/106327988-26973f80-62d3-11eb-99aa-52f1809f9d57.mp4)
  
  Guide is a work in progress...
  
DOWNLOADS
=========

Programs to download
--------------------
OBS Studio - [https://obsproject.com/](https://obsproject.com/)  
OBS Websocket - [https://github.com/Palakis/obs-websocket/releases/latest](https://github.com/Palakis/obs-websocket/releases/latest)  
NGINX (w/ RTMP) - [https://github.com/illuspas/nginx-rtmp-win32/releases/latest](https://github.com/illuspas/nginx-rtmp-win32/releases/latest)  
Node.js or OBSCommand - [https://nodejs.org/](https://nodejs.org/) or [https://github.com/REALDRAGNET/OBSCommand/releases/latest](https://github.com/REALDRAGNET/OBSCommand/releases/latest)  
mpv - [https://mpv.io/installation/](https://mpv.io/installation/)  
VLC 64-bit - [https://www.videolan.org/vlc/download-windows.html](https://www.videolan.org/vlc/download-windows.html)


OBS WebSocket 5.x vs OBS WebSocket 4.x
======================================

Barring any issues or bugs, **OBS WebSocket 5.0.0** is expected to be packaged with **OBS 28**. It is currently available now separately for download. Unfortunately all applications are not yet compatible with **OBS WebSocket 5.x**.

**Loopy SRT Monitor** however is compatible with both **OBS WebSocket 5.x** and **OBS WebSocket 4.9.1**, and will automatically detect and run what has been configured. If you still require compatibility with **OBS WebSocket 4.9.1**, this allows you one of the following options:

Option #1
---

- Following installation, continue to use **OBS WebSocket 4.9.1**, and run ```install.cmd``` with option ```2```. This will download ```obs-websocket-js 4.0.3```, the last version to be compatible with **OBS WebSocket 4.x**.

- **Loopy SRT Monitor** configuration file ```config.ini``` must then be edited with the ```WebSocketConnection``` setting changed to ```obs-websocket-js```. ```obs-websocket-http``` will not work with **OBS WebSocket 4.x**.

Option #2
---

- Following installation, download and install the latest ```obs-websocket-5.x```, followed by ```obs-websocket-4.9.1-compat```. Available in the **OBS -> Tools** menu should now be two independent settings, one for _4.x compat_, and one for _5.x_. Server Port numbers cannot be the same.

- To continue using **obs-websocket-js**, run ```install.cmd``` with option ```1```. If not already downloaded, this will download the latest ```obs-websocket-js``` compatible with **OBS WebSocket 5.x**.

- **Loopy SRT Monitor** configuration file ```config.ini``` must then be edited with the ```WebSocketConnection``` setting changed to ```obs-websocket-js```.

- To use ```obs-websocket-http``` however, follow the instructions in the installation and/or _readme.txt_ file and confirm ```config.ini``` contains ```WebSocketConnection=obs-websocket-http```.


INSTALLATION
============

OBS Studio
----------
This guide assumes you have OBS installed and have spent time streaming and an understanding of how it works.

OBS Websocket
-------------
After installing OBS Websocket, create a password in OBS (Tools -> Websockets Server Settings).

NGINX
-----
After extracting to a location of your choice, use 'nginx.exe' to start the server, and 'stop.bat' to shut down.

* See the "Modifications" section below for recommended changes.

Node.js
-------
Following installation of Node.js, run __install.cmd__ within '__Documents\Loopy NGINX Monitor__' to install "obs-websocket-js" and complete the installation.

OBSCommand
----------
Extract the files into the 'OBSCommand' folder within '__Documents\Loopy NGINX Monitor__'.

mpv
---
Extract and use __updater.bat__ to install to a location of your choice.

* See the "Modifications" section below for recommended changes.

VLC 64-bit
----------
This will be used in OBS as a **_VLC Video Source_** for the "fallback" streams. It has features not currently available with the default OBS video player.

* See the "Modifications" section below for recommended changes.


MODIFICATIONS
=============

NGINX
------
Open __nginx.conf__

Find the line: `"listen 1935;"`  
Below that line, add: `"ping 3s;"`

Alternatively, download [nginx.conf](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/nginx/nginx.conf) from here.

mpv
---
Download [rtmp_stream_1.cmd](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/mpv/rtmp_stream_1.cmd) and copy to the _mpv_ root folder (where __mpv.com__ and __mpv.exe__ are located).

If two cameras/scenes are to be used, download an additional file [rtmp_stream_2.cmd](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/mpv/rtmp_stream_2.cmd) and also copy to the _mpv_ root folder (where __mpv.com__ and __mpv.exe__ are located).

These **.cmd** file/s are to be executed AFTER __nginx.exe__.

Download [input.conf](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/mpv/input.conf) and copy to the _mpv_ folder (where __fonts.conf__ is located). This will disable several mouse and keyboard functions from accidentally seeking/interrupting a live stream.

Download [mpv.conf](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/mpv/mpv.conf) and also copy to the _mpv_ folder (where __fonts.conf__ is located). This add the "rtmpstream" profile which will allow for stable streaming. mpv has many options, so any suggestions to further improve the stability are welcome. Also contained in the file are high quality OpenGL options for most modern hardware that support them, providing improved video quality over the standard mpv settings. Remove these OpenGL options if they cause problems, though this is unlikely.

mpv.conf also allows the use of [ffmpeg filters](https://ffmpeg.org/ffmpeg-filters.html). One handy filter could be the audio equalizer. The following is an example of what you can append to the "rtmpstream" profile to give some GoPro microphones a subjectively required treble boost, as the high frequencies may be tapered off otherwise:

```
# GoPro Mic EQ
af=equalizer=f=10:t=o:w=1:g=-0.1,equalizer=f=90:t=o:w=1:g=2,equalizer=f=150:t=o:w=1:g=0.8,equalizer=f=560:t=o:w=1:g=-2.8,equalizer=f=2800:t=o:w=1:g=0.5,equalizer=f=3900:t=o:w=1:g=2,equalizer=f=4800:t=o:w=1:g=1,equalizer=f=7200:t=o:w=1:g=4.5,equalizer=f=9000:t=o:w=1:g=1.5,equalizer=f=13500:t=o:w=1:g=9,equalizer=f=19000:t=o:w=1:g=3
```


VLC 64-bit
----------
Open OBS, and within the "fallback" scene, add a source **_VLC Video Source_**. Select your video that viewers will see when your connection is lost. The following settings are recommended: **_Loop Playlist_** enabled, **_Pause when not visible, unpause when visible_** enabled.

AdiIRC
------

[AdiIRC](https://www.adiirc.com/) is a free alternative to mIRC. If you have set **_FileStatusOutput=true_** for the purpose of outputting the stream status to a chat room, a sample script is supplied here. Edit [vars.ini](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/adiirc/vars.ini) with your channel name, and place in AdiIRC's root folder. Then load the [outputRTMP.ini](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/adiirc/outputRTMP.ini) script. Alt+R can be used to quickly access scripts.


ADDITIONAL STEPS
================
OS firewall and router settings may prevent connecting to your home PC from an external source, such as mobile internet. Check firewall settings to allow the correct programs/ports to be accessed. Set a new rule for both inbound and outbound for TCP port 1935.

Investigate how to use your router's "Port Forwarding" setting for allowing connections to port 1935. For security reasons, this should only be enabled while in use. If port forwarding does not work for your connection, your ISP might have CG-NAT enabled for your service. Confirm whether or not this is the case, and if so, contact your ISP and ask that it be disabled.

If you have been assigned a dynamic IP address from your ISP, [No-IP](https://www.noip.com/) is a great solution. I have used their service since the mid 2000's without issue.

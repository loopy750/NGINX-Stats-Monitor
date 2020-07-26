# Loopy NGINX Stats Monitor
  
Latest release available [here](https://github.com/loopy750/NGINX-Stats-Monitor/releases/latest).

This is a program to assist with "IRL streaming" for popular streaming websites such as Twitch, using OBS Studio. This program is currently in use by Twitch streamers and has been proven to a be a valuable asset to their stream.

Using a "homemade" solution to RTMP stream from your location back to your home PC, this program will automatically switch to a "fallback" OBS scene whenever your connection is lost, and is restored when your connection resumes.

Basic features (**_MultiCameraSwitch=false_**) allow a simple two-scene scenario, either "LIVE" or "FALLBACK" scene.

Advanced features (**_MultiCameraSwitch=true_**) consider for a two-camera multiple-scene scenario, and can alternate between scenes depending on the combination of cameras/streams used, i.e. stream 1, stream 2, and both stream 1&2 simultaneously. See 'readme.txt' for a full description regarding these and other settings.
  
  
  
Guide is a work in progress...
  
  
DOWNLOADS
=========

Programs to download
--------------------
OBS Studio - [https://obsproject.com/](https://obsproject.com/)  
OBS Websocket - [https://github.com/Palakis/obs-websocket/releases/latest](https://github.com/Palakis/obs-websocket/releases/latest)  
NGINX (w/ RTMP) - [https://github.com/illuspas/nginx-rtmp-win32/releases/latest](https://github.com/illuspas/nginx-rtmp-win32/releases/latest)  
OBSCommand - [https://github.com/REALDRAGNET/OBSCommand/releases/latest](https://github.com/REALDRAGNET/OBSCommand/releases/latest)  
mpv - [https://mpv.io/installation/](https://mpv.io/installation/)  
VLC 64-bit - [https://www.videolan.org/vlc/download-windows.html](https://www.videolan.org/vlc/download-windows.html)


INSTALLATION
============

OBS Studio
----------
This guide assumes you have OBS installed and have spent time streaming and an understanding of how it works.

OBS Websocket
-------------
After installing OBS Websocket, setup a password in OBS (Tools -> Websockets Server Settings).

NGINX
-----
After extracting to a location of your choice, use 'nginx.exe' to start the server, and 'stop.bat' to shut down.

* See the "Modifications" section below for recommended changes.

OBSCommand
----------
Extract the files into the 'OBSCommand' folder with the 'NGINX Stats Monitor' folder.

mpv
---
Extract and use 'updater.bat' to install to a location of your choice.

* See the "Modifications" section below for recommended changes.

VLC 64-bit
----------
This will be used in OBS as a "VLC Video Source" for the "fallback" streams. It has features not currently available with the default OBS video player.

* See the "Modifications" section below for recommended changes.


MODIFICATIONS
=============

NGINX
------
Open 'nginx.conf'

Find the line: `"listen 1935;"`  
Below that line, add: `"ping 3s;"`

Alternatively, download [nginx.conf](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/nginx.conf) from here.

mpv
---
Download [**rtmp_stream_1.cmd**](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/rtmp_stream_1.cmd) and copy to the _mpv_ root folder (where 'mpv.com' and 'mpv.exe' are located).

If two cameras/scenes are to be used, download an additional file [**rtmp_stream_2.cmd**](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/rtmp_stream_2.cmd) and also copy to the _mpv_ root folder (where 'mpv.com' and 'mpv.exe' are located).

These **.cmd** file/s are to be executed AFTER 'nginx.exe'.

Download [**input.conf**](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/input.conf) and copy to the _mpv_ folder (where 'fonts.conf' is located). This will disable several mouse and keyboard functions from accidentally seeking/interrupting a live stream.

Download [**mpv.conf**](https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor/master/modifications/mpv.conf) and also copy to the _mpv_ folder (where 'fonts.conf' is located). This will enable high quality OpenGL options for most modern hardware that supports them. Remove these options if they cause problems.

VLC 64-bit
----------
Open OBS, and within the "fallback" scene, add a source 'VLC Video Source'. Select your video that viewers will see when your connection is lost. The following settings are recommended: **_Loop Playlist_** enabled, **_Pause when not visible, unpause when visible_** enabled.


ADDITIONAL STEPS
================
OS firewall and router settings may prevent connecting to your home PC from an external source, such as mobile internet. Check firewall settings to allow the correct programs/ports to be accessed.

Investigate how to use your router's "Port Forwarding" setting for allowing connections to port 1935. For security reasons, this should only be enabled while in use. If port forwarding does not work for your connection, your ISP might have CG-NAT enabled for your service. Confirm whether or not this is the case, and if so, contact your ISP and ask that it be disabled.

If you have been assigned a dynamic IP address from your ISP, [No-IP](https://www.noip.com/) is a great solution. I have used their service since the mid 2000's without issue.

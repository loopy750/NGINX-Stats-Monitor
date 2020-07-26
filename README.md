# Loopy NGINX Stats Monitor

Latest release available [here](https://github.com/loopy750/NGINX-Stats-Monitor/releases/latest).

This is a program to assist with "IRL streaming" for popular streaming websites such as Twitch, using OBS Studio. This program is currently in use by Twitch streamers and has been proven to a be a valuable asset to their stream.

Using a "homemade" solution to RTMP stream from your location back to your home PC, this program will automatically switch to a "fallback" OBS scene whenever your connection is lost, and is restored when your connection resumes.


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
This guide assumes you have OBS installed and spent time streaming and an understanding of how it works.

OBS Websocket
-------------
After installing OBS Websocket, setup a password in OBS (Tools -> Websockets Server Settings).

NGINX
-----
After extracting to a location of your choice, 'nginx.exe' is to start the server, and 'stop.bat' is to shut down.

* See the "Modifications" section for recommended changes.

OBSCommand
----------
Extract the files into the 'OBSCommand' folder with the 'NGINX Stats Monitor' folder.

mpv
---
Use 'updater.bat' to install to a location of your choice.

* See the "Modifications" section for recommended changes.

VLC 64-bit
----------
This will be used in OBS as a "VLC Video Source" for the fallback streams. It has features not currently available in the default OBS video player.

* See the "Modifications" section for recommended changes.


MODIFICATIONS
=============

NGINX
------
Open 'nginx.conf'

Find the line: "listen 1935;"
Below that line, add: "ping 3s;"

OS firewall and router settings may prevent connecting to your home PC from an external source, such as mobile internet. Check firewall settings to allow the correct programs/ports to be accessed.

Investigate how to use "Port Forwarding" for your router to allow connections to port 1935. For security reasons, this should only be enabled when in use. If port forwarding does not work for your connection, your ISP might have CG-NAT enabled. Confirm whether or not this is the case and if so, contact your ISP and ask for it to be disabled.

mpv
---
Inside the mpv folder, create a file called 'rtmp_stream_1.cmd'. Edit and add the following line:
`@START "mpv - stream1" /MIN mpv --vd-lavc-threads=1 --cache-pause=no --demuxer-lavf-analyzeduration=1 --no-osd-bar --no-osc --input-media-keys=no --window-minimized=yes --fs --force-window --audio-device=auto -vf lavfi=[fade=in:10:50] rtmp://127.0.0.1/live/stream1`

If two cameras/scenes are to be used, create an additional file called 'rtmp_stream_2.cmd'. Edit and add the following line:
`@START "mpv - stream2" /MIN mpv --vd-lavc-threads=1 --cache-pause=no --demuxer-lavf-analyzeduration=1 --no-osd-bar --no-osc --input-media-keys=no --window-minimized=yes --fs --force-window --audio-device=auto -vf lavfi=[fade=in:10:50] rtmp://127.0.0.1/live/stream2`

These file/s are to be executed AFTER 'nginx.exe'.

VLC 64-bit
----------
Open OBS, and within the 'fallback' scene, add a source 'VLC Video Source'. Select your video that viewers will see when your connection is lost. The following settings are recommended: "Loop Playlist" enabled, "Pause when not visible, unpause when visible".


OPTIONAL STEPS
==============
If you have a dynamic IP address, [No-IP](https://www.noip.com/) is a great solution. I have used their service for over 15 years without issue.

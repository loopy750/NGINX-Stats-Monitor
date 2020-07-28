:Start
@ECHO OFF
ECHO Waiting for connection...
ECHO.
mpv --profile=rtmpstream rtmp://127.0.0.1/live/stream2
TIMEOUT /T 10
ECHO.
GOTO Start &:: Restart in an extremely rare case where mpv is shut down because of EOF

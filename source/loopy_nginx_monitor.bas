OPTION _EXPLICIT
': This program uses
': InForm - GUI library for QB64 - v1.2
': Fellippe Heitor, 2016-2019 - fellippe@qb64.org - @fellippeheitor
': https://github.com/FellippeHeitor/InForm
'-----------------------------------------------------------

': Controls' IDs: ------------------------------------------------------------------
DIM SHARED LoopyNginxMonitor AS LONG
DIM SHARED FileMenu AS LONG
DIM SHARED NGINX AS LONG
DIM SHARED Status AS LONG
DIM SHARED Settings AS LONG
DIM SHARED CurrentScene AS LONG
DIM SHARED Debug AS LONG
DIM SHARED Stream1 AS LONG
DIM SHARED Stream2 AS LONG
DIM SHARED OptionsMenu AS LONG
DIM SHARED HelpMenu AS LONG
DIM SHARED FileMenuExit AS LONG
DIM SHARED RMTPLB AS LONG
DIM SHARED clientsLB AS LONG
DIM SHARED VideoLB AS LONG
DIM SHARED AudioLB AS LONG
DIM SHARED InBytesLB AS LONG
DIM SHARED OutBytesLB AS LONG
DIM SHARED InBitssLB AS LONG
DIM SHARED OutBitssLB AS LONG
DIM SHARED TimeLB AS LONG
DIM SHARED rtmp_nacceptedLB AS LONG
DIM SHARED rtmp_codec_nclientsLB AS LONG
DIM SHARED rtmp_codec_videoLB AS LONG
DIM SHARED rtmp_codec_audioLB AS LONG
DIM SHARED rtmp_bytes_inLB AS LONG
DIM SHARED rtmp_bytes_outLB AS LONG
DIM SHARED rtmp_bw_inLB AS LONG
DIM SHARED rtmp_bw_outLB AS LONG
DIM SHARED rtmp_uptimeLB AS LONG
DIM SHARED InBytesDifferenceLB AS LONG
DIM SHARED StreamFailTimerLB AS LONG
DIM SHARED FailCountLB AS LONG
DIM SHARED ServerPingLB AS LONG
DIM SHARED UpdateIntervalLB AS LONG
DIM SHARED Kb_DiffLB AS LONG
DIM SHARED Timer_FailLB AS LONG
DIM SHARED Timer_Fail_CountLB AS LONG
DIM SHARED tPing3LB AS LONG
DIM SHARED td_updateLB AS LONG
DIM SHARED BandwidthThresholdLB AS LONG
DIM SHARED StreamFailDelayLB AS LONG
DIM SHARED MultiCameraSwitchLB AS LONG
DIM SHARED Bandwidth_ThresholdLB AS LONG
DIM SHARED Stream_Fail_DelayLB AS LONG
DIM SHARED MultiCameraSwitchStatusLB AS LONG
DIM SHARED TimerLB AS LONG
DIM SHARED TimerSnapshotLB AS LONG
DIM SHARED td_displayVarLB AS LONG
DIM SHARED mouseXVarLB AS LONG
DIM SHARED mouseYVarLB AS LONG
DIM SHARED __ERRORLINEVarLB AS LONG
DIM SHARED Debug_TimerLB AS LONG
DIM SHARED Debug_Timer_SnapshotLB AS LONG
DIM SHARED td_displayLB AS LONG
DIM SHARED mouseXLB AS LONG
DIM SHARED mouseYLB AS LONG
DIM SHARED __ERRORLINELB AS LONG
DIM SHARED InBytesLB2 AS LONG
DIM SHARED InBytesDifferenceLB2 AS LONG
DIM SHARED failLB AS LONG
DIM SHARED multiStream1LB AS LONG
DIM SHARED Kb_Diff_stream1LB AS LONG
DIM SHARED Timer_Fail_Stream1LB AS LONG
DIM SHARED Scene_CurrentLB AS LONG
DIM SHARED PictureBox1 AS LONG
DIM SHARED InBytesLB3 AS LONG
DIM SHARED InBytesDifferenceLB3 AS LONG
DIM SHARED failLB2 AS LONG
DIM SHARED multiStream2LB AS LONG
DIM SHARED Kb_Diff_stream2LB AS LONG
DIM SHARED Timer_Fail_Stream2LB AS LONG
DIM SHARED OptionsMenuDebug AS LONG
DIM SHARED HelpMenuCheckForUpdates AS LONG
DIM SHARED OptionsMenuFullscreen AS LONG
DIM SHARED IndicatorLB AS LONG
DIM SHARED HelpMenuAbout AS LONG
DIM SHARED StatusLB AS LONG

': External modules: ---------------------------------------------------------------
'$INCLUDE:'InForm_Deleted.bas'
'$INCLUDE:'InForm\InForm.ui'
'$INCLUDE:'InForm\xp.uitheme'
'$INCLUDE:'loopy_nginx_monitor.frm'

': Event procedures: ---------------------------------------------------------------
'$INCLUDE:'image.png.MEM'
SUB __UI_BeforeInit
    $VERSIONINFO:CompanyName=loopy750
    $VERSIONINFO:ProductName=Loopy Nginx Monitor
    $VERSIONINFO:Comments=Monitor Nginx RTMP Streams
    $VERSIONINFO:FileDescription=Loopy Nginx Monitor
    $VERSIONINFO:FILEVERSION#=1,3,1,0
    $VERSIONINFO:PRODUCTVERSION#=1,3,1,0
    $CHECKING:ON
    $RESIZE:OFF
    IF ERR = 0 THEN
        $EXEICON:'.\icon.ico'
        _TITLE "Loopy Nginx Stats Monitor - loopy750"
    END IF
    Ver$ = "1.3.1"

    'Always on top : ------------------------------------------------------------------
    CONST HWND_TOPMOST%& = -1
    CONST SWP_NOSIZE%& = &H1
    CONST SWP_NOMOVE%& = &H2
    CONST SWP_SHOWWINDOW%& = &H40

    DECLARE DYNAMIC LIBRARY "user32"
        FUNCTION SetWindowPos& (BYVAL hWnd AS LONG, BYVAL hWndInsertAfter AS _OFFSET, BYVAL X AS INTEGER, BYVAL Y AS INTEGER, BYVAL cx AS INTEGER, BYVAL cy AS INTEGER, BYVAL uFlags AS _OFFSET)
        FUNCTION GetForegroundWindow& 'find currently focused process handle
    END DECLARE

    'DIM Myhwnd AS _UNSIGNED LONG 'Commented until Always on top can work
    'Myhwnd = _WINDOWHANDLE

    FGwin& = GetForegroundWindow&
    '----------------------------------------------------------------------------------
END SUB

SUB __UI_OnLoad
    'NGINX
    SetCaption rtmp_nacceptedLB, "-"
    SetCaption rtmp_codec_nclientsLB, "-"
    SetCaption rtmp_codec_videoLB, "-"
    SetCaption rtmp_codec_audioLB, "-"
    SetCaption rtmp_bytes_inLB, "-"
    SetCaption rtmp_bytes_outLB, "-"
    SetCaption rtmp_bw_inLB, "-"
    SetCaption rtmp_bw_outLB, "-"
    SetCaption rtmp_uptimeLB, "-"
    'Status
    SetCaption Kb_DiffLB, "-"
    SetCaption Timer_FailLB, "-"
    SetCaption Timer_Fail_CountLB, "-"
    SetCaption tPing3LB, "-"
    SetCaption td_updateLB, "-"
    'Settings
    SetCaption Bandwidth_ThresholdLB, "-"
    SetCaption Stream_Fail_DelayLB, "-"
    SetCaption MultiCameraSwitchStatusLB, "-"
    'Stream #1
    SetCaption multiStream1LB, "-"
    SetCaption Kb_Diff_stream1LB, "-"
    SetCaption Timer_Fail_Stream1LB, "-"
    'Stream #2
    SetCaption multiStream2LB, "-"
    SetCaption Kb_Diff_stream2LB, "-"
    SetCaption Timer_Fail_Stream2LB, "-"
    'Current Scene
    SetCaption Scene_CurrentLB, "-"
    'Debug
    SetCaption Debug_TimerLB, "-"
    SetCaption Debug_Timer_SnapshotLB, "-"
    SetCaption td_displayLB, "-"
    SetCaption mouseXLB, "-"
    SetCaption mouseYLB, "-"
    SetCaption __ERRORLINELB, "-"
    'Debug titles
    SetCaption TimerLB, "-" 'TIMER
    SetCaption TimerSnapshotLB, "-" 'TIMER (snapshot)
    SetCaption td_displayVarLB, "-" 'td_display var
    SetCaption mouseXVarLB, "-" 'mouseX var
    SetCaption mouseYVarLB, "-" 'mouseY var
    SetCaption __ERRORLINEVarLB, "-" '_ERRORLINE var

    BG = _RGB(32, 32, 32)
    Exe_OK = 1
    config_main = "config.ini"
    URL = "127.0.0.1"
    Port = "8080"
    fileStat = "stat"
    filePrevious = "returnPreviousScene.tmp"
    IF _FILEEXISTS(filePrevious) THEN KILL filePrevious
    _ALLOWFULLSCREEN OFF
    RANDOMIZE TIMER

    'Check config
    Bandwidth_Threshold = 25
    Stream_Fail_Delay = 10
    Desktop_Width_Position = 160
    Desktop_Height_Position = 100
    IF NOT _FILEEXISTS(config_main) THEN RefreshDisplayRequest = 1: Error_msg$ = "File " + CHR$(34) + config_main + CHR$(34) + " cannot be accessed, check if it exists. (#1)": _DELAY 3
    IF _FILEEXISTS(config_main) THEN
        OPEN config_main FOR INPUT AS #4 'Basic INI management, nothing fancy needed
        DO
            LINE INPUT #4, file4$
            IF LEFT$(file4$, 1) <> "#" AND LEFT$(file4$, 1) <> ";" AND LEFT$(file4$, 1) <> "" THEN
                EqualFound = INSTR(file4$, "=")
                IF EqualFound THEN
                    file4_var$ = LEFT$(file4$, INSTR(file4$, "=") - 1)
                    file4_val$ = MID$(file4$, INSTR(file4$, "=") + 1)
                    IF file4_var$ = "BandwidthThreshold" THEN Bandwidth_Threshold = VAL(file4_val$)
                    IF file4_var$ = "StreamFailDelay" THEN Stream_Fail_Delay = VAL(file4_val$)
                    IF file4_var$ = "xWindow" THEN Desktop_Width_Position = VAL(file4_val$)
                    IF file4_var$ = "yWindow" THEN Desktop_Height_Position = VAL(file4_val$)
                    IF file4_var$ = "SceneOK" THEN Scene_OK = file4_val$
                    IF file4_var$ = "SceneFail" THEN Scene_Fail = file4_val$
                    IF file4_var$ = "SceneIntro" THEN Scene_Intro = file4_val$
                    IF file4_var$ = "ServerIP" THEN URL = file4_val$
                    IF file4_var$ = "ServerPort" THEN Port = file4_val$
                    IF file4_var$ = "WebsocketAddress" THEN OBS_URL = file4_val$
                    IF file4_var$ = "WebsocketPassword" THEN OBS_PW = file4_val$
                    IF file4_var$ = "CheckUpdateOnStartup" THEN CheckUpdateOnStartup = file4_val$
                    IF file4_var$ = "MultiCameraSwitch" THEN MultiCameraSwitch$ = file4_val$
                    IF file4_var$ = "urlStream1" THEN urlStream1 = file4_val$
                    IF file4_var$ = "urlStream2" THEN urlStream2 = file4_val$
                    IF file4_var$ = "titleScene1" THEN titleScene1 = file4_val$
                    IF file4_var$ = "titleScene2" THEN titleScene2 = file4_val$
                    IF file4_var$ = "titleScene12" THEN titleScene12 = file4_val$
                    IF file4_var$ = "returnPreviousScene" THEN returnPreviousScene = file4_val$
                    IF file4_var$ = "returnPreviousSceneRemember" THEN returnPreviousSceneRemember$ = file4_val$
                END IF
            END IF
        LOOP UNTIL EOF(4)
        CLOSE #4
        IF Bandwidth_Threshold <= 0 THEN
            Bandwidth_Threshold = 0
        ELSEIF Bandwidth_Threshold >= 9999 THEN Bandwidth_Threshold = 9999
        END IF

        IF Stream_Fail_Delay <= 3 THEN
            Stream_Fail_Delay = 3
        ELSEIF Stream_Fail_Delay >= 99 THEN Stream_Fail_Delay = 99
        END IF

        IF Desktop_Width_Position <= -(_DESKTOPWIDTH * 4) THEN Desktop_Width_Position = -(_DESKTOPWIDTH * 4)
        IF Desktop_Width_Position >= (_DESKTOPWIDTH * 4) THEN Desktop_Width_Position = (_DESKTOPWIDTH * 4)
        IF Desktop_Width_Position = -9999 THEN Desktop_Width_Position = -9999

        IF Desktop_Height_Position <= -(_DESKTOPHEIGHT * 4) THEN Desktop_Height_Position = -(_DESKTOPHEIGHT * 4)
        IF Desktop_Height_Position >= (_DESKTOPHEIGHT * 4) THEN Desktop_Height_Position = (_DESKTOPHEIGHT * 4)
        IF Desktop_Height_Position = -9999 THEN Desktop_Height_Position = -9999

        IF Desktop_Width_Position = -9999 AND Desktop_Height_Position = -9999 THEN
        ELSE
            _SCREENMOVE Desktop_Width_Position, Desktop_Height_Position
        END IF
    END IF
    IF MultiCameraSwitch$ = "true" THEN __MultiCameraSwitch = 1 ELSE __MultiCameraSwitch = 0
    IF returnPreviousScene = "true" THEN __returnPreviousScene = 1 ELSE __returnPreviousScene = 0
    IF returnPreviousSceneRemember$ = "true" THEN returnPreviousSceneRemember = 1 ELSE returnPreviousSceneRemember = 0
    IF __MultiCameraSwitch = 0 THEN __returnPreviousScene = 0: returnPreviousSceneRemember = 0

    IF CheckUpdateOnStartup = "true" THEN 'This is repeated - need a better solution
        file224$ = ""
        updateResult$ = ""
        _DELAY .25
        SHELL _HIDE "%ComSpec% /C curl -H " + CHR$(34) + "Cache-Control: no-cache" + CHR$(34) + " https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor-Version/master/checkversion.txt > checkversion.txt"
        _DELAY .25
        IF _FILEEXISTS("checkversion.txt") THEN
            OPEN "checkversion.txt" FOR INPUT AS #224
            DO UNTIL EOF(224)
                IF LOF(224) = 0 THEN NoKill = 1: EXIT DO 'Overkill with EOF checking, but just being safe
                IF EOF(224) THEN EXIT DO
                LINE INPUT #224, file224$
            LOOP
        END IF
        CLOSE #224
        IF _FILEEXISTS("checkversion.txt") THEN KILL "checkversion.txt"
        updateResult$ = file224$
        IF file224$ <> Ver$ THEN verCheck$ = "A new version is available..."
        IF file224$ = "" OR file224$ = "404: Not Found" THEN verCheck$ = "Unable to check for new version..."
        IF file224$ = Ver$ THEN verCheck$ = "You are using the latest version..."
    END IF

    Port_Client$ = "TCP/IP:" + Port + ":"

    IF Scene_OK = "" OR Scene_Fail = "" OR Scene_Intro = "" OR URL = "" OR Port = "" OR OBS_URL = "" THEN RefreshDisplayRequest = 1: Error_msg$ = "Variable/s for scenes empty, check if " + CHR$(34) + config_main + CHR$(34) + " exists. (#2)": _DELAY 3

    IF __MultiCameraSwitch = 0 THEN
        Scene_Current$ = Scene_OK
        SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_OK + CHR$(34)
    END IF

    IF __MultiCameraSwitch = 1 THEN
        Scene_Current$ = titleScene12
        SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + titleScene12 + CHR$(34)
    END IF

    _DELAY .25
    _TITLE "Loopy Nginx Stats Monitor"

    IF __MultiCameraSwitch = 0 THEN Control(Stream1).Hidden = True: Control(Stream2).Hidden = True

    ON TIMER(1) Timer01
    TIMER ON
END SUB

SUB __UI_BeforeUpdateDisplay
    'This event occurs at approximately 30 frames per second.
    'You can change the update frequency by calling SetFrameRate DesiredRate%
    SetFrameRate 30

    IF RefreshDisplayRequest = 1 THEN
        RefreshDisplayRequest = 0
        TIMER STOP
        CLS , _RGB(1, 120, 220)
        BSOD& = __imageMEM&("face_sad_x.png")
        _PUTIMAGE (50, 50)-(107, 162), BSOD&
        _FREEIMAGE BSOD&
        COLOR _RGB(254, 254, 254), _RGB(1, 120, 220)
        _PRINTSTRING (37, 12 * 18), "Program encountered an error and needs to restart."
        _PRINTSTRING (37, 14 * 18), Error_msg$
        _PRINTSTRING (37, 22 * 18), "Program will resume shortly"
        _DISPLAY
        _DELAY 10
        CLS , BG
        TIMER ON
    END IF

    IF Debug = 1 THEN
        DO WHILE _MOUSEINPUT
            mouseX = _MOUSEX
            mouseY = _MOUSEY
        LOOP

        Debug_Timer# = TIMER(.001)
        TIMEms Debug_Timer#, 0
        SetCaption (Debug_TimerLB), tout + " sec   "
        TIMEms td_display#, 1
        SetCaption (td_displayLB), tout + " sec   "
        SetCaption (mouseXLB), LTRIM$(STR$(mouseX + 1)) + "   "
        SetCaption (mouseYLB), LTRIM$(STR$(mouseY + 1)) + "   "
        SetCaption (__ERRORLINELB), LTRIM$(STR$(_ERRORLINE)) + "   "
    END IF

    IF updateDisplay >= 1 THEN
        updateDisplayCounter = updateDisplayCounter + 1
        IF updateDisplayCounter >= 300 THEN
            file224$ = ""
            verCheck$ = ""
            updateResult$ = ""
            updateDisplay = 0
            updateDisplayCounter = 0
            SetCaption StatusLB, ""
        END IF
    END IF

    ProgressCounter = ProgressCounter + 1 ' | / - \ | / - \
    IF ProgressCounter >= 1 AND ProgressCounter <= 8 THEN SetCaption IndicatorLB, "|"
    IF ProgressCounter >= 9 AND ProgressCounter <= 16 THEN SetCaption IndicatorLB, "/"
    IF ProgressCounter >= 17 AND ProgressCounter <= 24 THEN SetCaption IndicatorLB, "-"
    IF ProgressCounter >= 25 AND ProgressCounter <= 32 THEN SetCaption IndicatorLB, "\"
    IF ProgressCounter >= 33 AND ProgressCounter <= 40 THEN SetCaption IndicatorLB, "|"
    IF ProgressCounter >= 41 AND ProgressCounter <= 48 THEN SetCaption IndicatorLB, "/"
    IF ProgressCounter >= 49 AND ProgressCounter <= 56 THEN SetCaption IndicatorLB, "-"
    IF ProgressCounter >= 57 AND ProgressCounter <= 64 THEN SetCaption IndicatorLB, "\"
    IF ProgressCounter >= 64 THEN ProgressCounter = 1
END SUB

SUB __UI_BeforeUnload
    'If you set __UI_UnloadSignal = False here you can
    'cancel the user's request to close.

END SUB

SUB __UI_Click (id AS LONG)
    SELECT CASE id
        CASE LoopyNginxMonitor

        CASE FileMenu

        CASE OptionsMenu

        CASE HelpMenu

        CASE NGINX

        CASE Status

        CASE Settings

        CASE CurrentScene

        CASE Debug

        CASE Stream1

        CASE Stream2

        CASE OptionsMenuAlwaysOnTop
            IF AlwaysOnTop <> 1 THEN
                AlwaysOnTop = 1
                FGwin& = GetForegroundWindow&: IF Myhwnd <> FGwin& THEN y& = SetWindowPos&(Myhwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_SHOWWINDOW)
            ELSE
                AlwaysOnTop = 0
                FGwin& = GetForegroundWindow&: IF Myhwnd <> FGwin& THEN y& = SetWindowPos&(Myhwnd, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE)
            END IF

        CASE OptionsMenuDebug
            IF Debug <> 1 THEN
                Debug = 1
                Control(Debug).Disabled = False
            ELSE
                Debug = 0
                Control(Debug).Disabled = True
            END IF

        CASE OptionsMenuFullscreen
            IF FullScreen <> 1 THEN
                FullScreen = 1
                _FULLSCREEN _SQUAREPIXELS , _SMOOTH
            ELSE
                FullScreen = 0
                _FULLSCREEN _OFF
            END IF

        CASE FileMenuExit
            IF _FILEEXISTS(filePrevious) THEN KILL filePrevious
            SYSTEM

        CASE HelpMenuCheckForUpdates
            file224$ = ""
            updateResult$ = ""
            _DELAY .25
            SHELL _HIDE "%ComSpec% /C curl -H " + CHR$(34) + "Cache-Control: no-cache" + CHR$(34) + " https://raw.githubusercontent.com/loopy750/NGINX-Stats-Monitor-Version/master/checkversion.txt > checkversion.txt"
            _DELAY .25
            IF _FILEEXISTS("checkversion.txt") THEN
                OPEN "checkversion.txt" FOR INPUT AS #224
                DO UNTIL EOF(224)
                    IF LOF(224) = 0 THEN NoKill = 1: EXIT DO 'Overkill with EOF checking, but just being safe
                    IF EOF(224) THEN EXIT DO
                    LINE INPUT #224, file224$
                LOOP
            END IF
            CLOSE #224
            IF _FILEEXISTS("checkversion.txt") THEN KILL "checkversion.txt"
            updateResult$ = file224$
            IF file224$ <> Ver$ THEN verCheck$ = "A new version is available..."
            IF file224$ = "" OR file224$ = "404: Not Found" THEN verCheck$ = "Unable to check for new version..."
            IF file224$ = Ver$ THEN verCheck$ = "You are using the latest version..."
            IF verCheck <> "" THEN updateDisplayCounter = 0

        CASE HelpMenuAbout
            About = MessageBox(SPACE$(3) + "Loopy Nginx Stats Monitor v" + Ver$ + "\n\n" + SPACE$(20) + "07/20 - loopy750\n\n" + SPACE$(3) + "https://www.github.com/loopy750", "About", MsgBox_OkOnly)

        CASE RMTPLB

        CASE clientsLB

        CASE VideoLB

        CASE AudioLB

        CASE InBytesLB

        CASE OutBytesLB

        CASE InBitssLB

        CASE OutBitssLB

        CASE TimeLB

        CASE rtmp_nacceptedLB

        CASE rtmp_codec_nclientsLB

        CASE rtmp_codec_videoLB

        CASE rtmp_codec_audioLB

        CASE rtmp_bytes_inLB

        CASE rtmp_bytes_outLB

        CASE rtmp_bw_inLB

        CASE rtmp_bw_outLB

        CASE rtmp_uptimeLB

        CASE InBytesDifferenceLB

        CASE StreamFailTimerLB

        CASE FailCountLB

        CASE ServerPingLB

        CASE UpdateIntervalLB

        CASE Kb_DiffLB

        CASE Timer_FailLB

        CASE Timer_Fail_CountLB

        CASE tPing3LB

        CASE td_updateLB

        CASE BandwidthThresholdLB

        CASE StreamFailDelayLB

        CASE MultiCameraSwitchLB

        CASE Bandwidth_ThresholdLB

        CASE Stream_Fail_DelayLB

        CASE MultiCameraSwitchStatusLB

        CASE TimerLB

        CASE TimerSnapshotLB

        CASE td_displayVarLB

        CASE mouseXVarLB

        CASE mouseYVarLB

        CASE __ERRORLINEVarLB

        CASE Debug_TimerLB

        CASE Debug_Timer_SnapshotLB

        CASE td_displayLB

        CASE mouseXLB

        CASE mouseYLB

        CASE __ERRORLINELB

        CASE InBytesLB2

        CASE InBytesDifferenceLB2

        CASE failLB

        CASE InBytesLB3

        CASE InBytesDifferenceLB3

        CASE failLB2

        CASE multiStream1LB

        CASE Kb_Diff_stream1LB

        CASE Timer_Fail_Stream1LB

        CASE multiStream2LB

        CASE Kb_Diff_stream2LB

        CASE Timer_Fail_Stream2LB

        CASE Scene_CurrentLB

    END SELECT
END SUB

SUB __UI_MouseEnter (id AS LONG)
    SELECT CASE id
        CASE LoopyNginxMonitor

        CASE FileMenu

        CASE OptionsMenu

        CASE HelpMenu

        CASE NGINX

        CASE Status

        CASE Settings

        CASE CurrentScene

        CASE Debug

        CASE Stream1

        CASE Stream2

        CASE OptionsMenuAlwaysOnTop

        CASE OptionsMenuDebug

        CASE FileMenuExit

        CASE HelpMenuAbout

        CASE RMTPLB

        CASE clientsLB

        CASE VideoLB

        CASE AudioLB

        CASE InBytesLB

        CASE OutBytesLB

        CASE InBitssLB

        CASE OutBitssLB

        CASE TimeLB

        CASE rtmp_nacceptedLB

        CASE rtmp_codec_nclientsLB

        CASE rtmp_codec_videoLB

        CASE rtmp_codec_audioLB

        CASE rtmp_bytes_inLB

        CASE rtmp_bytes_outLB

        CASE rtmp_bw_inLB

        CASE rtmp_bw_outLB

        CASE rtmp_uptimeLB

        CASE InBytesDifferenceLB

        CASE StreamFailTimerLB

        CASE FailCountLB

        CASE ServerPingLB

        CASE UpdateIntervalLB

        CASE Kb_DiffLB

        CASE Timer_FailLB

        CASE Timer_Fail_CountLB

        CASE tPing3LB

        CASE td_updateLB

        CASE BandwidthThresholdLB

        CASE StreamFailDelayLB

        CASE MultiCameraSwitchLB

        CASE Bandwidth_ThresholdLB

        CASE Stream_Fail_DelayLB

        CASE MultiCameraSwitchStatusLB

        CASE TimerLB

        CASE TimerSnapshotLB

        CASE td_displayVarLB

        CASE mouseXVarLB

        CASE mouseYVarLB

        CASE __ERRORLINEVarLB

        CASE Debug_TimerLB

        CASE Debug_Timer_SnapshotLB

        CASE td_displayLB

        CASE mouseXLB

        CASE mouseYLB

        CASE __ERRORLINELB

        CASE InBytesLB2

        CASE InBytesDifferenceLB2

        CASE failLB

        CASE InBytesLB3

        CASE InBytesDifferenceLB3

        CASE failLB2

        CASE multiStream1LB

        CASE Kb_Diff_stream1LB

        CASE Timer_Fail_Stream1LB

        CASE multiStream2LB

        CASE Kb_Diff_stream2LB

        CASE Timer_Fail_Stream2LB

        CASE Scene_CurrentLB

    END SELECT
END SUB

SUB __UI_MouseLeave (id AS LONG)
    SELECT CASE id
        CASE LoopyNginxMonitor

        CASE FileMenu

        CASE OptionsMenu

        CASE HelpMenu

        CASE NGINX

        CASE Status

        CASE Settings

        CASE CurrentScene

        CASE Debug

        CASE Stream1

        CASE Stream2

        CASE OptionsMenuAlwaysOnTop

        CASE OptionsMenuDebug

        CASE FileMenuExit

        CASE HelpMenuAbout

        CASE RMTPLB

        CASE clientsLB

        CASE VideoLB

        CASE AudioLB

        CASE InBytesLB

        CASE OutBytesLB

        CASE InBitssLB

        CASE OutBitssLB

        CASE TimeLB

        CASE rtmp_nacceptedLB

        CASE rtmp_codec_nclientsLB

        CASE rtmp_codec_videoLB

        CASE rtmp_codec_audioLB

        CASE rtmp_bytes_inLB

        CASE rtmp_bytes_outLB

        CASE rtmp_bw_inLB

        CASE rtmp_bw_outLB

        CASE rtmp_uptimeLB

        CASE InBytesDifferenceLB

        CASE StreamFailTimerLB

        CASE FailCountLB

        CASE ServerPingLB

        CASE UpdateIntervalLB

        CASE Kb_DiffLB

        CASE Timer_FailLB

        CASE Timer_Fail_CountLB

        CASE tPing3LB

        CASE td_updateLB

        CASE BandwidthThresholdLB

        CASE StreamFailDelayLB

        CASE MultiCameraSwitchLB

        CASE Bandwidth_ThresholdLB

        CASE Stream_Fail_DelayLB

        CASE MultiCameraSwitchStatusLB

        CASE TimerLB

        CASE TimerSnapshotLB

        CASE td_displayVarLB

        CASE mouseXVarLB

        CASE mouseYVarLB

        CASE __ERRORLINEVarLB

        CASE Debug_TimerLB

        CASE Debug_Timer_SnapshotLB

        CASE td_displayLB

        CASE mouseXLB

        CASE mouseYLB

        CASE __ERRORLINELB

        CASE InBytesLB2

        CASE InBytesDifferenceLB2

        CASE failLB

        CASE InBytesLB3

        CASE InBytesDifferenceLB3

        CASE failLB2

        CASE multiStream1LB

        CASE Kb_Diff_stream1LB

        CASE Timer_Fail_Stream1LB

        CASE multiStream2LB

        CASE Kb_Diff_stream2LB

        CASE Timer_Fail_Stream2LB

        CASE Scene_CurrentLB

    END SELECT
END SUB

SUB __UI_FocusIn (id AS LONG)
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_FocusOut (id AS LONG)
    'This event occurs right before a control loses focus.
    'To prevent a control from losing focus, set __UI_KeepFocus = True below.
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_MouseDown (id AS LONG)
    SELECT CASE id
        CASE LoopyNginxMonitor

        CASE FileMenu

        CASE OptionsMenu

        CASE HelpMenu

        CASE NGINX

        CASE Status

        CASE Settings

        CASE CurrentScene

        CASE Debug

        CASE Stream1

        CASE Stream2

        CASE OptionsMenuAlwaysOnTop

        CASE OptionsMenuDebug

        CASE FileMenuExit

        CASE HelpMenuAbout

        CASE RMTPLB

        CASE clientsLB

        CASE VideoLB

        CASE AudioLB

        CASE InBytesLB

        CASE OutBytesLB

        CASE InBitssLB

        CASE OutBitssLB

        CASE TimeLB

        CASE rtmp_nacceptedLB

        CASE rtmp_codec_nclientsLB

        CASE rtmp_codec_videoLB

        CASE rtmp_codec_audioLB

        CASE rtmp_bytes_inLB

        CASE rtmp_bytes_outLB

        CASE rtmp_bw_inLB

        CASE rtmp_bw_outLB

        CASE rtmp_uptimeLB

        CASE InBytesDifferenceLB

        CASE StreamFailTimerLB

        CASE FailCountLB

        CASE ServerPingLB

        CASE UpdateIntervalLB

        CASE Kb_DiffLB

        CASE Timer_FailLB

        CASE Timer_Fail_CountLB

        CASE tPing3LB

        CASE td_updateLB

        CASE BandwidthThresholdLB

        CASE StreamFailDelayLB

        CASE MultiCameraSwitchLB

        CASE Bandwidth_ThresholdLB

        CASE Stream_Fail_DelayLB

        CASE MultiCameraSwitchStatusLB

        CASE TimerLB

        CASE TimerSnapshotLB

        CASE td_displayVarLB

        CASE mouseXVarLB

        CASE mouseYVarLB

        CASE __ERRORLINEVarLB

        CASE Debug_TimerLB

        CASE Debug_Timer_SnapshotLB

        CASE td_displayLB

        CASE mouseXLB

        CASE mouseYLB

        CASE __ERRORLINELB

        CASE InBytesLB2

        CASE InBytesDifferenceLB2

        CASE failLB

        CASE InBytesLB3

        CASE InBytesDifferenceLB3

        CASE failLB2

        CASE multiStream1LB

        CASE Kb_Diff_stream1LB

        CASE Timer_Fail_Stream1LB

        CASE multiStream2LB

        CASE Kb_Diff_stream2LB

        CASE Timer_Fail_Stream2LB

        CASE Scene_CurrentLB

    END SELECT
END SUB

SUB __UI_MouseUp (id AS LONG)
    SELECT CASE id
        CASE LoopyNginxMonitor

        CASE FileMenu

        CASE OptionsMenu

        CASE HelpMenu

        CASE NGINX

        CASE Status

        CASE Settings

        CASE CurrentScene

        CASE Debug

        CASE Stream1

        CASE Stream2

        CASE OptionsMenuAlwaysOnTop

        CASE OptionsMenuDebug

        CASE FileMenuExit

        CASE HelpMenuAbout

        CASE RMTPLB

        CASE clientsLB

        CASE VideoLB

        CASE AudioLB

        CASE InBytesLB

        CASE OutBytesLB

        CASE InBitssLB

        CASE OutBitssLB

        CASE TimeLB

        CASE rtmp_nacceptedLB

        CASE rtmp_codec_nclientsLB

        CASE rtmp_codec_videoLB

        CASE rtmp_codec_audioLB

        CASE rtmp_bytes_inLB

        CASE rtmp_bytes_outLB

        CASE rtmp_bw_inLB

        CASE rtmp_bw_outLB

        CASE rtmp_uptimeLB

        CASE InBytesDifferenceLB

        CASE StreamFailTimerLB

        CASE FailCountLB

        CASE ServerPingLB

        CASE UpdateIntervalLB

        CASE Kb_DiffLB

        CASE Timer_FailLB

        CASE Timer_Fail_CountLB

        CASE tPing3LB

        CASE td_updateLB

        CASE BandwidthThresholdLB

        CASE StreamFailDelayLB

        CASE MultiCameraSwitchLB

        CASE Bandwidth_ThresholdLB

        CASE Stream_Fail_DelayLB

        CASE MultiCameraSwitchStatusLB

        CASE TimerLB

        CASE TimerSnapshotLB

        CASE td_displayVarLB

        CASE mouseXVarLB

        CASE mouseYVarLB

        CASE __ERRORLINEVarLB

        CASE Debug_TimerLB

        CASE Debug_Timer_SnapshotLB

        CASE td_displayLB

        CASE mouseXLB

        CASE mouseYLB

        CASE __ERRORLINELB

        CASE InBytesLB2

        CASE InBytesDifferenceLB2

        CASE failLB

        CASE InBytesLB3

        CASE InBytesDifferenceLB3

        CASE failLB2

        CASE multiStream1LB

        CASE Kb_Diff_stream1LB

        CASE Timer_Fail_Stream1LB

        CASE multiStream2LB

        CASE Kb_Diff_stream2LB

        CASE Timer_Fail_Stream2LB

        CASE Scene_CurrentLB

    END SELECT
END SUB

SUB __UI_KeyPress (id AS LONG)
    'When this event is fired, __UI_KeyHit will contain the code of the key hit.
    'You can change it and even cancel it by making it = 0
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_TextChanged (id AS LONG)
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_ValueChanged (id AS LONG)
    SELECT CASE id
    END SELECT
END SUB

SUB __UI_FormResized

END SUB

SUB Error_Exit (Error_msg$)

    TIMER STOP
    CLS , _RGB(1, 120, 220)
    BSOD& = __imageMEM&("face_sad_x.png")
    _PUTIMAGE (50, 50)-(107, 162), BSOD&
    _FREEIMAGE BSOD&
    COLOR _RGB(254, 254, 254), _RGB(1, 120, 220)
    _PRINTSTRING (37, 12 * 18), "Program encountered an error and needs to restart."
    _PRINTSTRING (37, 14 * 18), Error_msg$
    _PRINTSTRING (37, 22 * 18), "Program will resume shortly"
    _DISPLAY
    _DELAY 10
    CLS , BG
    Refresh_Request = 1
    TIMER ON

END SUB

SUB Indicators

    TIMER STOP
    COLOR _RGB(100, 100, 164), BGA
    AliveIndicator! = AliveIndicator! + .125

    IF AliveIndicator! <= 0 OR AliveIndicator! >= 9 THEN
        AliveIndicator! = 1
        __BGA = __BGA + 1
        IF __BGA = 1 THEN BGA = _RGB(30, 64, 96)
        IF __BGA > 1 THEN BGA = _RGB(32, 32, 32): __BGA = 0
    END IF

    aioffsetX = 689: aioffsetY = 425
    SELECT CASE AliveIndicator!
        CASE 1, 5
            LINE (6 + aioffsetX, 0 + aioffsetY)-(6 + aioffsetX, 10 + aioffsetY), BGA: LINE (2 + aioffsetX, 9 + aioffsetY)-(10 + aioffsetX, 1 + aioffsetY), _RGB(128, 192, 240)
        CASE 2, 6
            LINE (2 + aioffsetX, 9 + aioffsetY)-(10 + aioffsetX, 1 + aioffsetY), BGA: LINE (0 + aioffsetX, 5 + aioffsetY)-(12 + aioffsetX, 5 + aioffsetY), _RGB(128, 192, 240)
        CASE 3, 7
            LINE (0 + aioffsetX, 5 + aioffsetY)-(12 + aioffsetX, 5 + aioffsetY), BGA: LINE (2 + aioffsetX, 1 + aioffsetY)-(10 + aioffsetX, 9 + aioffsetY), _RGB(128, 192, 240)
        CASE 4, 8
            LINE (2 + aioffsetX, 1 + aioffsetY)-(10 + aioffsetX, 9 + aioffsetY), BGA: LINE (6 + aioffsetX, 0 + aioffsetY)-(6 + aioffsetX, 10 + aioffsetY), _RGB(128, 192, 240)
    END SELECT
    TIMER ON

END SUB

SUB IMAGEPUT (x, y, Lx, Ly)

    TIMER STOP
    _BLEND
    FOR Pt& = 1 TO (x * y)
        READ image_data(Pt&)
    NEXT

    x2 = 1
    FOR Px = 0 TO (x - 1)
        FOR Py = 0 TO (y - 1)
            PSET (Px + Lx, Py + Ly), image_data(x2)
            x2 = x2 + 1
        NEXT
    NEXT
    _DONTBLEND
    TIMER ON

END SUB

SUB TIMEms (tout#, plus)

    TIMER STOP
    tout = ""
    tout2# = tout#
    toutint# = FIX(tout2#)
    IF tout# >= 0 THEN
        toutdec# = (tout2# - toutint#) + 1
        IF plus THEN tout = tout + "+"
    ELSE
        toutdec# = (tout2# - toutint#) - 1
        IF toutint# = 0 THEN tout = tout + "-"
    END IF
    tout = tout + LTRIM$(STR$(toutint#))
    IF tout# >= 0 THEN tout = tout + "." + MID$(LTRIM$(STR$(toutdec#)), 3, 3) ELSE tout = tout + "." + MID$(LTRIM$(STR$(toutdec#)), 4, 3)
    IF LEN(STR$(toutdec#)) = 5 THEN tout = tout + "0"
    IF LEN(STR$(toutdec#)) = 4 THEN tout = tout + "00"
    IF LEN(STR$(toutdec#)) = 2 THEN tout = tout + "000"
    'Output to tout
    TIMER ON

END SUB

SUB IMAGECLEAR (x, y, Lx, Ly)

    TIMER STOP
    _BLEND
    x2 = 1
    FOR Px = 0 TO (x - 1)
        FOR Py = 0 TO (y - 1)
            PSET (Px + Lx, Py + Ly), BG
            x2 = x2 + 1
        NEXT
    NEXT
    _DONTBLEND
    TIMER ON

END SUB

SUB calcbw (bout#, bits)

    TIMER STOP
    bout = ""
    bout2# = bout#
    boutnodec = 0

    IF bits = 0 THEN
        SELECT CASE bout2#
            CASE IS < 1048576
                boutint# = bout2# / 1024
                boutm$ = "KB"
            CASE IS < 1073741824
                boutint# = bout2# / 1048576
                boutm$ = "MB"
            CASE IS >= 1073741824
                boutint# = bout2# / 1073741824
                boutm$ = "GB"
        END SELECT
        boutdec# = boutint# + 1
        boutint# = FIX(boutint#)
        bout = STR$(boutint#)
        IF boutdec# = FIX(boutdec#) THEN
            boutdec$ = "000"
        ELSE
            boutdec$ = MID$(LTRIM$(STR$(boutdec#)), INSTR(LTRIM$(STR$(boutdec#)), ".") + 1, 3)
        END IF
        IF LEN(LTRIM$(STR$(boutint#))) >= 5 THEN
            boutdec$ = LEFT$(boutdec$, 1)
        ELSE
            IF LEN(boutdec$) = 2 THEN boutdec$ = boutdec$ + "0"
            IF LEN(boutdec$) = 1 THEN boutdec$ = boutdec$ + "00"
            IF LEN(boutdec$) = 0 THEN boutdec$ = boutdec$ + "000"
        END IF
        IF bout# < 1073741824 THEN boutdec$ = LEFT$(boutdec$, 2)
        bout = bout + "." + boutdec$ + " " + boutm$
        'Output to bout
    ELSE
        SELECT CASE bout2#
            CASE IS < 1048576
                boutint# = bout2# / 1024
                boutm$ = "Kb/s"
                boutnodec = 1
            CASE IS < 1073741824
                boutint# = bout2# / 1048576
                boutm$ = "Mb/s"
            CASE IS > 1073741824
                boutint# = bout2# / 1073741824
                boutm$ = "Gb/s"
        END SELECT
        boutdec# = boutint# + 1
        boutint# = FIX(boutint#)
        bout = STR$(boutint#)
        IF boutdec# = FIX(boutdec#) THEN
            boutdec$ = "00"
        ELSE
            boutdec$ = MID$(LTRIM$(STR$(boutdec#)), INSTR(LTRIM$(STR$(boutdec#)), ".") + 1, 2)
        END IF
        IF LEN(LTRIM$(STR$(boutint#))) >= 5 THEN boutdec$ = LEFT$(boutdec$, 1)
        boutdec$ = "." + boutdec$
        IF boutnodec = 1 THEN boutdec$ = ""
        bout = bout + boutdec$ + " " + boutm$
        'Output to bout
    END IF
    TIMER ON

END SUB

FUNCTION calc_nginx$ (convertTime#, includeSec)

    TIMER STOP
    IF convertTime# >= 3596400 THEN convertTime# = 3596400
    t_hr = convertTime# \ 3600
    t_min = (convertTime# - (3600 * t_hr)) \ 60
    t_sec = (convertTime# - (3600 * t_hr)) - (t_min * 60)
    calc_nginx$ = LTRIM$(STR$(t_hr)) + "h " + LTRIM$(STR$(t_min)) + "m "
    IF includeSec = 1 THEN calc_nginx$ = calc_nginx$ + LTRIM$(STR$(t_sec)) + "s   "
    TIMER ON

END FUNCTION

SUB Timer01
    td_update# = TIMER(.001) - timer1#
    timer1# = TIMER(.001)

    IF Debug = 0 THEN
        SetCaption Debug_TimerLB, "-"
        SetCaption Debug_Timer_SnapshotLB, "-"
        SetCaption td_displayLB, "-"
        SetCaption mouseXLB, "-"
        SetCaption mouseYLB, "-"
        SetCaption __ERRORLINELB, "-"
        SetCaption (TimerLB), "-" 'TIMER
        SetCaption (TimerSnapshotLB), "-" 'TIMER (snapshot)
        SetCaption (td_displayVarLB), "-" 'td_display var
        SetCaption (mouseXVarLB), "-" 'mouseX var
        SetCaption (mouseYVarLB), "-" 'mouseY var
        SetCaption (__ERRORLINEVarLB), "-" '_ERRORLINE var
    ELSEIF Debug = 1 THEN
        SetCaption (TimerLB), "TIMER" 'TIMER
        SetCaption (TimerSnapshotLB), "TIMER (snapshot)" 'TIMER (snapshot)
        SetCaption (td_displayVarLB), "td_display var" 'td_display var
        SetCaption (mouseXVarLB), "mouseX var" 'mouseX var
        SetCaption (mouseYVarLB), "mouseY var" 'mouseY var
        SetCaption (__ERRORLINEVarLB), "_ERRORLINE var" '_ERRORLINE var
        TIMEms Debug_Timer#, 0
        SetCaption (Debug_Timer_SnapshotLB), tout + " sec "
    END IF

    IF verCheck$ <> "" THEN
        SetCaption StatusLB, verCheck$
        updateDisplay = 1
    END IF

    IF __returnPreviousScene = 1 THEN
        returnPreviousSceneTime = returnPreviousSceneTime + 1
        IF returnPreviousSceneTime >= 3 THEN returnPreviousSceneTime = 1 ELSE GOTO Exit_returnPreviousSceneCheck
        returnFirstCheck = 1
        SHELL _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /command=GetCurrentScene > " + filePrevious
        _DELAY .01
        ON ERROR GOTO PUT_Fail
        PUT_Refresh = 1
        IF _FILEEXISTS(filePrevious) THEN
            OPEN filePrevious FOR INPUT AS #96
            DO UNTIL EOF(96)
                IF LOF(96) = 0 THEN NoKill = 1: EXIT DO 'Overkill with EOF checking, but just being safe
                IF EOF(96) THEN EXIT DO
                LINE INPUT #96, file96$
                findSceneName = INSTR(file96$, "  " + CHR$(34) + "name" + CHR$(34) + ": " + CHR$(34))
                IF findSceneName THEN
                    findSceneName2 = INSTR(findSceneName + 11, file96$, CHR$(34))
                    IF streamsUp$ <> "0" THEN previousScene$ = MID$(file96$, findSceneName + 11, findSceneName2 - 12)
                    previousSceneDisplay$ = MID$(file96$, findSceneName + 11, findSceneName2 - 12)
                    EXIT DO 'Output to previousScene$
                END IF
            LOOP
        END IF
    END IF
    CLOSE #96

    IF NoKill = 1 THEN NoKill = 0 ELSE IF _FILEEXISTS(filePrevious) THEN KILL filePrevious
    ON ERROR GOTO 0
    PUT_Refresh = 0

    Exit_returnPreviousSceneCheck:
    rtmp_naccepted$ = "": rtmp_bytes_in$ = "": rtmp_bytes_out$ = "": rtmp_bw_in$ = "": rtmp_bw_out$ = "": rtmp_codec_video$ = "": rtmp_codec_audio$ = "": rtmp_codec_nclients$ = ""
    rtmp_codec_nclients# = 0: rtmp_codec_nclients_temp# = 0
    a$ = "": a2$ = "": d$ = "": I = 0: i2 = 0: i3 = 0: stats_rtmp.xml$ = ""

    tPing1# = TIMER(.001)
    client = _OPENCLIENT(Port_Client$ + URL)
    tPing2# = TIMER(.001)
    tPing3# = (tPing2# - tPing1#)

    IF client THEN
        NULL = NULL
    ELSE RefreshDisplayRequest = 1: Error_msg$ = "Unable to connect, check if " + CHR$(34) + URL + ":" + Port + CHR$(34) + " is correct. (#3)": _DELAY 3: GOTO URL_OK
    END IF

    EOL$ = CHR$(13) + CHR$(10)
    xHeader1$ = "GET /" + fileStat + " HTTP/1.1" + EOL$
    xHeader2$ = "Cache-Control: no-cache" + EOL$
    xHeader3$ = "Pragma: no-cache" + EOL$
    xHeader4$ = "User-Agent: Wget/1.20.3 (mingw32)" + EOL$
    xHeader5$ = "Accept: */*" + EOL$
    xHeader6$ = "Accept-Encoding: identity" + EOL$
    xHeader7$ = "Host: " + URL + ":" + Port + EOL$
    xHeader8$ = "Connection: Keep-Alive" + EOL$
    xHeader9$ = EOL$ + EOL$
    x$ = xHeader1$ + xHeader2$ + xHeader3$ + xHeader4$ + xHeader5$ + xHeader6$ + xHeader7$ + xHeader8$ + xHeader9$

    ON ERROR GOTO PUT_Fail
    PUT #client, , x$

    Timer_GET! = TIMER
    DO
        GET #client, , a2$
        a$ = a$ + a2$
        I = INSTR(a$, "Content-Length:")
        IF I THEN
            i2 = INSTR(I, a$, EOL$)
            IF i2 THEN
                l = VAL(MID$(a$, I + 15, i2 - I - 14))
                i3 = INSTR(i2, a$, EOL$ + EOL$)
                IF i3 THEN
                    i3 = i3 + 4 'move i3 to start of data
                    IF (LEN(a$) - i3 + 1) = l THEN
                        CLOSE client ' CLOSE CLIENT
                        d$ = MID$(a$, i3, l)
                        EXIT DO
                    END IF ' available data = l
                END IF ' i3
            END IF ' i2
        END IF ' i
    LOOP UNTIL TIMER > Timer_GET! + 10
    CLOSE client
    stats_rtmp.xml$ = d$

    GOTO URL_OK

    'PUT_Fail:
    'IF ERR THEN CLS: _PRINTSTRING (20, 30), "ERR, _ERRORLINE:" + STR$(ERR) + "," + STR$(_ERRORLINE): _AUTODISPLAY: _DELAY 3: IF PUT_Refresh = 1 THEN PUT_Refresh = 0: Refresh_Request = 1: RESUME NEXT ELSE RESUME NEXT

    URL_OK:
    IF INSTR(stats_rtmp.xml$, "<uptime>") THEN rtmp_uptime# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<uptime>") + 8, 16))
    IF INSTR(stats_rtmp.xml$, "<naccepted>") THEN rtmp_naccepted# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<naccepted>") + 11, 16))
    IF INSTR(stats_rtmp.xml$, "<bytes_in>") THEN rtmp_bytes_in# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<bytes_in>") + 10, 16))
    IF INSTR(stats_rtmp.xml$, "<bytes_out>") THEN rtmp_bytes_out# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<bytes_out>") + 11, 16))
    IF INSTR(stats_rtmp.xml$, "<bw_in>") THEN rtmp_bw_in# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<bw_in>") + 7, 16))
    IF INSTR(stats_rtmp.xml$, "<bw_out>") THEN rtmp_bw_out# = VAL(MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<bw_out>") + 8, 16))
    IF INSTR(stats_rtmp.xml$, "</frame_rate><codec>") THEN rtmp_codec_video$ = MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "</frame_rate><codec>") + 20, 4)
    IF INSTR(stats_rtmp.xml$, "<audio><codec>") THEN rtmp_codec_audio$ = MID$(stats_rtmp.xml$, INSTR(stats_rtmp.xml$, "<audio><codec>") + 14, 3)

    IF __MultiCameraSwitch = 1 THEN
        Stream% = 0
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, "<name>" + urlStream1 + "</name>")
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, CHR$(13) + CHR$(10))
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, CHR$(13) + CHR$(10))
        multiStream1# = VAL(MID$(stats_rtmp.xml$, Stream% + 12, 16))
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, "<name>" + urlStream2 + "</name>")
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, CHR$(13) + CHR$(10))
        Stream% = INSTR(Stream% + 1, stats_rtmp.xml$, CHR$(13) + CHR$(10))
        multiStream2# = VAL(MID$(stats_rtmp.xml$, Stream% + 12, 16))
    END IF

    rtmp_codec_nclients# = 0
    rtmp_codec_nclients_temp# = 0
    DO
        pos_xml_m& = INSTR(pos_xml_m& + 1, stats_rtmp.xml$, "<nclients>")
        rtmp_codec_nclients_temp# = VAL(MID$(stats_rtmp.xml$, pos_xml_m& + 10, 16))
        IF rtmp_codec_nclients_temp# > rtmp_codec_nclients# THEN rtmp_codec_nclients# = rtmp_codec_nclients_temp#
    LOOP UNTIL pos_xml_m& = 0

    'temp1 variables
    IF nginx_warmup = 0 THEN Kb_Diff# = (Bandwidth_Threshold + 1)
    IF rtmp_bytes_in# = 0 THEN rtmp_bytes_in# = 1
    rtmp_bytes_in_temp1# = rtmp_bytes_in#
    IF rtmp_bytes_in_temp1# >= 1 AND rtmp_bytes_in_temp2# >= 1 THEN
        Kb_Diff# = INT((rtmp_bytes_in_temp1# - rtmp_bytes_in_temp2#) / 128)
    END IF

    IF Kb_Diff# >= Bandwidth_Threshold THEN Timer_Fail = 0
    IF Kb_Diff# <= Bandwidth_Threshold AND nginx_warmup = 1 THEN Timer_Fail = Timer_Fail + 1
    IF Timer_Fail >= 19999 THEN Timer_Fail = 19999

    SetCaption (rtmp_nacceptedLB), "A:" + STR$(rtmp_naccepted#)
    SetCaption (rtmp_codec_nclientsLB), LTRIM$(STR$(rtmp_codec_nclients#))
    IF rtmp_codec_video$ <> "" THEN SetCaption (rtmp_codec_videoLB), rtmp_codec_video$ ELSE SetCaption rtmp_codec_videoLB, "-"
    IF rtmp_codec_audio$ <> "" THEN SetCaption (rtmp_codec_audioLB), rtmp_codec_audio$ ELSE SetCaption rtmp_codec_audioLB, "-"
    calcbw rtmp_bytes_in#, 0
    SetCaption (rtmp_bytes_inLB), LTRIM$(bout)
    calcbw rtmp_bytes_out#, 0
    SetCaption (rtmp_bytes_outLB), LTRIM$(bout)
    calcbw rtmp_bw_in#, 1
    SetCaption (rtmp_bw_inLB), LTRIM$(bout)
    calcbw rtmp_bw_out#, 1
    SetCaption (rtmp_bw_outLB), LTRIM$(bout)
    SetCaption (rtmp_uptimeLB), calc_nginx$(rtmp_uptime#, 0)

    IF Kb_Diff# <= Bandwidth_Threshold THEN Control(Kb_DiffLB).ForeColor = RED_WARNING ELSE Control(Kb_DiffLB).ForeColor = GREEN_OK
    IF Timer_Fail >= Stream_Fail_Delay THEN Control(Kb_DiffLB).ForeColor = RED_FAIL
    SetCaption (Kb_DiffLB), LTRIM$(STR$(Kb_Diff#)) + " Kb/s"

    IF Timer_Fail >= 1 THEN Control(Timer_FailLB).ForeColor = RED_WARNING: SD = 1: _TITLE "Stream Down!" ELSE Control(Timer_FailLB).ForeColor = GREEN_OK
    IF Timer_Fail >= Stream_Fail_Delay THEN Control(Timer_FailLB).ForeColor = RED_FAIL
    SetCaption (Timer_FailLB), calc_nginx$(Timer_Fail, 1)

    IF Timer_Fail = 0 AND SD = 1 THEN SD = 0: _TITLE "Loopy Nginx Stats Monitor"

    IF Timer_Fail >= 1 THEN Control(Timer_Fail_CountLB).ForeColor = RED_WARNING ELSE Control(Timer_Fail_CountLB).ForeColor = GREEN_OK
    IF Timer_Fail >= Stream_Fail_Delay THEN Control(Timer_Fail_CountLB).ForeColor = RED_FAIL
    IF Timer_Fail_Count <> 1 THEN SetCaption (Timer_Fail_CountLB), LTRIM$(STR$(Timer_Fail_Count)) + " times" ELSE SetCaption (Timer_Fail_CountLB), LTRIM$(STR$(Timer_Fail_Count)) + " time"

    TIMEms tPing3#, 0
    SetCaption (tPing3LB), LTRIM$(STR$(VAL(tout) * 1000)) + "ms"

    IF nginx_warmup = 1 THEN
        IF td_update# <= 0.001 THEN td_update# = 0.001
        IF td_update# >= 9.999 THEN td_update# = 9.999
        IF td_update# <= 0.989 OR td_update# >= 1.011 THEN Control(td_updateLB).ForeColor = RED_WARNING ELSE Control(td_updateLB).ForeColor = GREEN_OK
        TIMEms td_update#, 0
        SetCaption (td_updateLB), tout + " sec "
    END IF

    SetCaption (Bandwidth_ThresholdLB), LTRIM$(STR$(Bandwidth_Threshold)) + " Kb/s"
    SetCaption (Stream_Fail_DelayLB), calc_nginx$(Stream_Fail_Delay, 1)
    IF __MultiCameraSwitch = 0 THEN SetCaption (MultiCameraSwitchStatusLB), "Disabled" ELSE SetCaption (MultiCameraSwitchStatusLB), "Enabled"
    IF __returnPreviousScene = 1 THEN SetCaption (Scene_CurrentLB), LEFT$(previousSceneDisplay$, 20) ELSE SetCaption (Scene_CurrentLB), LEFT$(Scene_Current$, 20)

    IF __MultiCameraSwitch = 1 THEN
        'temp1_stream1 variables
        IF nginx_warmup = 0 THEN Kb_Diff_stream1# = (Bandwidth_Threshold + 1)
        IF multiStream1# = 0 THEN multiStream1# = 1
        multiStream1_temp1# = multiStream1#
        IF multiStream1_temp1# >= 1 AND multiStream1_temp2# >= 1 THEN
            Kb_Diff_stream1# = INT((multiStream1_temp1# - multiStream1_temp2#) / 128)
        END IF

        IF Kb_Diff_stream1# >= Bandwidth_Threshold THEN Timer_Fail_Stream1 = 0
        IF Kb_Diff_stream1# <= Bandwidth_Threshold AND nginx_warmup = 1 THEN Timer_Fail_Stream1 = Timer_Fail_Stream1 + 1
        IF Timer_Fail_Stream1 >= 19999 THEN Timer_Fail_Stream1 = 19999

        'temp1_stream2 variables
        IF nginx_warmup = 0 THEN Kb_Diff_stream2# = (Bandwidth_Threshold + 1)
        IF multiStream2# = 0 THEN multiStream2# = 1
        multiStream2_temp1# = multiStream2#
        IF multiStream2_temp1# >= 1 AND rtmp_bytes_in_temp2# >= 1 THEN
            Kb_Diff_stream2# = INT((multiStream2_temp1# - multiStream2_temp2#) / 128)
        END IF

        IF Kb_Diff_stream2# >= Bandwidth_Threshold THEN Timer_Fail_Stream2 = 0
        IF Kb_Diff_stream2# <= Bandwidth_Threshold AND nginx_warmup = 1 THEN Timer_Fail_Stream2 = Timer_Fail_Stream2 + 1
        IF Timer_Fail_Stream2 >= 19999 THEN Timer_Fail_Stream2 = 19999

        calcbw multiStream1#, 0
        SetCaption (multiStream1LB), LTRIM$(bout)

        IF Kb_Diff_stream1# < 0 THEN Kb_Diff_stream1# = 0 'Dirty fix for now

        IF Kb_Diff_stream1# <= Bandwidth_Threshold THEN Control(Kb_Diff_stream1LB).ForeColor = RED_WARNING ELSE Control(Kb_Diff_stream1LB).ForeColor = GREEN_OK
        IF Timer_Fail_Stream1 >= Stream_Fail_Delay THEN Control(Kb_Diff_stream1LB).ForeColor = RED_FAIL
        SetCaption (Kb_Diff_stream1LB), LTRIM$(STR$(Kb_Diff_stream1#)) + " Kb/s"

        IF Timer_Fail_Stream1 >= 1 THEN Control(Timer_Fail_Stream1LB).ForeColor = RED_WARNING ELSE Control(Timer_Fail_Stream1LB).ForeColor = GREEN_OK
        IF Timer_Fail_Stream1 >= Stream_Fail_Delay THEN Control(Timer_Fail_Stream1LB).ForeColor = RED_FAIL
        SetCaption (Timer_Fail_Stream1LB), calc_nginx$(Timer_Fail_Stream1, 1)

        calcbw multiStream2#, 0
        SetCaption (multiStream2LB), LTRIM$(bout)

        IF Kb_Diff_stream2# < 0 THEN Kb_Diff_stream2# = 0 'Dirty fix for now

        IF Kb_Diff_stream2# <= Bandwidth_Threshold THEN Control(Kb_Diff_stream2LB).ForeColor = RED_WARNING ELSE Control(Kb_Diff_stream2LB).ForeColor = GREEN_OK
        IF Timer_Fail_Stream2 >= Stream_Fail_Delay THEN Control(Kb_Diff_stream2LB).ForeColor = RED_FAIL
        SetCaption (Kb_Diff_stream2LB), LTRIM$(STR$(Kb_Diff_stream2#)) + " Kb/s"

        IF Timer_Fail_Stream2 >= 1 THEN Control(Timer_Fail_Stream2LB).ForeColor = RED_WARNING ELSE Control(Timer_Fail_Stream2LB).ForeColor = GREEN_OK
        IF Timer_Fail_Stream2 >= Stream_Fail_Delay THEN Control(Timer_Fail_Stream2LB).ForeColor = RED_FAIL
        SetCaption (Timer_Fail_Stream2LB), calc_nginx$(Timer_Fail_Stream2, 1)
    END IF

    IF Scene_OK = "" OR Scene_Fail = "" OR Scene_Intro = "" THEN RefreshDisplayRequest = 1: Error_msg$ = "Variable/s for scenes empty, check if " + CHR$(34) + config_main + CHR$(34) + " exists. (#4)": _DELAY 3

    IF Timer_Fail >= 1 AND Exe_OK = 1 AND streamsUp$ <> "0" THEN
        LoadImageMEM Control(PictureBox1), "tick_warning.png"
    ELSEIF Timer_Fail = 0 AND Exe_OK = 1 THEN
        LoadImageMEM Control(PictureBox1), "tick.png"
    END IF

    'Execute Stream OK
    IF __MultiCameraSwitch = 0 THEN
        IF Kb_Diff# >= Bandwidth_Threshold THEN
            Timer_Fail = 0
            Scene_Current$ = Scene_OK
            IF Exe_Fail = 1 THEN
                Exe_Fail = 0
                Exe_OK = 1
                LoadImageMEM Control(PictureBox1), "tick.png"
                SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_OK + CHR$(34)
                _DELAY .1
            END IF
        ELSE
            IF Timer_Fail >= Stream_Fail_Delay THEN
                IF Exe_OK = 1 THEN
                    Exe_OK = 0
                    Exe_Fail = 1
                    LoadImageMEM Control(PictureBox1), "cross.png"
                    IF Exe_Fail_First = 0 THEN
                        Exe_Fail_First = 1
                        Scene_Current$ = Scene_Intro
                        SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_Intro + CHR$(34)
                        _DELAY .1
                    ELSE
                        Scene_Current$ = Scene_Fail
                        SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_Fail + CHR$(34)
                        _DELAY .1
                        Timer_Fail_Count = Timer_Fail_Count + 1
                        IF Timer_Fail_Count >= 999 THEN Timer_Fail_Count = 999
                    END IF
                END IF
            END IF
        END IF
    END IF

    IF streamsUp$ <> "0" THEN lastStreamUp$ = streamsUp$

    IF streamsUp$ <> "0" AND returnPreviousSceneRemember = 1 THEN
        IF streamsUp$ = "1" THEN titleScene1 = previousScene$
        IF streamsUp$ = "2" THEN titleScene2 = previousScene$
        IF streamsUp$ = "12" THEN titleScene12 = previousScene$
    END IF

    IF __MultiCameraSwitch = 1 THEN
        IF Timer_Fail_Stream1 = 0 AND Timer_Fail_Stream2 >= Stream_Fail_Delay THEN
            IF streamsUp$ <> "1" THEN
                IF previousScene$ <> titleScene1 AND streamsUp$ = "0" THEN
                    IF lastStreamUp$ <> "1" THEN previousScene$ = titleScene1
                    Scene_Current$ = previousScene$
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + previousScene$ + CHR$(34)
                    _DELAY .1
                ELSE
                    Scene_Current$ = titleScene1
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + titleScene1 + CHR$(34)
                    _DELAY .1
                END IF
            END IF
            streamsUp$ = "1"
        END IF

        IF Timer_Fail_Stream1 >= Stream_Fail_Delay AND Timer_Fail_Stream2 = 0 THEN
            IF streamsUp$ <> "2" THEN
                IF previousScene$ <> titleScene2 AND streamsUp$ = "0" THEN
                    IF lastStreamUp$ <> "2" THEN previousScene$ = titleScene2
                    Scene_Current$ = previousScene$
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + previousScene$ + CHR$(34)
                ELSE
                    Scene_Current$ = titleScene2
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + titleScene2 + CHR$(34)
                END IF
            END IF
            _DELAY .1
            streamsUp$ = "2"
        END IF

        IF Timer_Fail_Stream1 = 0 AND Timer_Fail_Stream2 = 0 THEN
            IF streamsUp$ <> "12" THEN
                IF previousScene$ <> titleScene12 AND streamsUp$ = "0" THEN
                    IF lastStreamUp$ <> "12" THEN previousScene$ = titleScene12
                    Scene_Current$ = previousScene$
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + previousScene$ + CHR$(34)
                    _DELAY .1
                ELSE
                    Scene_Current$ = titleScene12
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + titleScene12 + CHR$(34)
                    _DELAY .1
                END IF
            END IF
            streamsUp$ = "12"
        END IF

        IF Timer_Fail_Stream1 >= Stream_Fail_Delay AND Timer_Fail_Stream2 >= Stream_Fail_Delay THEN
            IF streamsUp$ <> "0" THEN
                streamsUp$ = "0"
                LoadImageMEM Control(PictureBox1), "cross.png"
                IF Exe_Fail_First = 0 THEN
                    Exe_Fail_First = 1
                    Scene_Current$ = Scene_Intro
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_Intro + CHR$(34)
                    _DELAY .1
                ELSE
                    Scene_Current$ = Scene_Fail
                    SHELL _DONTWAIT _HIDE "%ComSpec% /C .\OBSCommand\OBSCommand.exe /server=" + OBS_URL + " /password=" + OBS_PW + " /scene=" + CHR$(34) + Scene_Fail + CHR$(34)
                    _DELAY .1
                    Timer_Fail_Count = Timer_Fail_Count + 1
                    IF Timer_Fail_Count >= 999 THEN Timer_Fail_Count = 999
                END IF
            END IF
        END IF
    END IF

    IF nginx_warmup = 1 AND returnFirstCheck = 1 AND __MultiCameraSwitch = 1 AND previousSceneDisplay$ = "" THEN RefreshDisplayRequest = 1: Error_msg$ = "Variable/s for scenes empty, check if OBS is open. (#5)": _DELAY 3

    'temp2 variables
    rtmp_bytes_in_temp2# = rtmp_bytes_in#

    'temp_stream1 & temp_stream2 variables
    multiStream1_temp2# = multiStream1#
    multiStream2_temp2# = multiStream2#

    IF Exe_Fail_First = 0 THEN
        Timer_Fail_First = Timer_Fail_First + 1
        IF (Stream_Fail_Delay + 3) - Timer_Fail_First <= 0 THEN Exe_Fail_First = 1
    END IF

    IF Exe_Fail_First_Stream1 = 0 THEN
        Timer_Fail_First_Stream1 = Timer_Fail_First_Stream1 + 1
        IF (Stream_Fail_Delay + 3) - Timer_Fail_First_Stream1 <= 0 THEN Exe_Fail_First_Stream1 = 1
    END IF

    IF Exe_Fail_First_Stream2 = 0 THEN
        Timer_Fail_First_Stream2 = Timer_Fail_First_Stream2 + 1
        IF (Stream_Fail_Delay + 3) - Timer_Fail_First_Stream2 <= 0 THEN Exe_Fail_First_Stream2 = 1
    END IF

    IF Refresh_Request = 1 THEN
        Refresh_Request = 0
        RefreshDisplayRequest = 1
    END IF

    IF nginx_warmup = 0 THEN nginx_warmup = 1

    td_display# = TIMER(.001) - timer1#
END SUB

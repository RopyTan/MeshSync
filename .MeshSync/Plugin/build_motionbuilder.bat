call toolchain.bat
rem call :Build 2019
rem call :Build 2018
rem call :Build 2017
call :Build 2016
rem call :Build 2015
exit /B 0

:Build
    set MOTIONBUILDER_VERSION=%~1
    echo target: %MOTIONBUILDER_VERSION%
    set MOTIONBUILDER_LIB_DIR=%cd%\External\OpenRealitySDK%MOTIONBUILDER_VERSION%\lib
    
    
    set MOTIONBUILDER_INCLUDE_DIR=%cd%\External\OpenRealitySDK%MOTIONBUILDER_VERSION%\include
    
    echo %MOTIONBUILDER_LIB_DIR% / %MOTIONBUILDER_INCLUDE_DIR%
	
    
    msbuild MeshSyncClientMotionBuilder.vcxproj /t:Build /p:Configuration=Release /p:Platform=x64 /m /nologo
    IF %ERRORLEVEL% NEQ 0 (
        pause
        exit /B 1
    )
    
    set DIST_DIR="dist\UnityMeshSync_MotionBuilder_Windows\"
    set CONTENT_DIR="%DIST_DIR%\MotionBuilder%MOTIONBUILDER_VERSION%"
    xcopy /Y _out\x64_Release\MeshSyncClientMotionBuilder%MOTIONBUILDER_VERSION%\MeshSyncClientMotionBuilder.dll "%CONTENT_DIR%\"
    exit /B 0

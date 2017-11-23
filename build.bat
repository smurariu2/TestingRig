@echo Off
set config=%1
if "%config%" == "" (
   set config=Release
)
 
set version=1.0.0
if not "%PackageVersion%" == "" (
   set version=%PackageVersion%
)

set nuget=
if "%nuget%" == "" (
	set nuget=nuget
)

%nuget% restore "src\TestingRig.sln"
@REM %WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild src\Terrarium.Sdk.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=diag /nr:false
@REM "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"  src\TestingRig.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=diag /nr:false

msbuild src\TestingRig.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=diag /nr:false

mkdir Build
mkdir Build\lib
mkdir Build\lib\netcoreapp2.0

%nuget% pack "src\TestingRig.nuspec" -NoPackageAnalysis -verbosity detailed -o Build -Version %version% -p Configuration="%config%"
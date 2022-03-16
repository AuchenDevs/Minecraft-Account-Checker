prompt Debug$g 
@echo off
set premium=na
cls
echo What nick you want to check?
set/p nick=nick: 
curl --insecure -XGET https://api.mojang.com/users/profiles/minecraft/%nick% | find /I "%nick%" >%temp%\MinecraftPremiumChecker.tmp && set premium=yes
cls
if "%premium%"=="na" (echo %nick% isn't a Minecraft premium account.) else (echo %nick% is actually a Minecraft premium account)
pause
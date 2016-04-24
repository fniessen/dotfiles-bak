@echo off

set file=%1
shift

echo cacls %file% /e /p %USERDOMAIN%\%USERNAME%:f
cacls %file% /e /p %USERDOMAIN%\%USERNAME%:f

@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"c:\vhd\work\hv\vendor\bundle\ruby\1.9.1\bin\ruby.exe" "c:/vhd/work/hv/vendor/bundle/ruby/1.9.1/bin/sass-convert" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"%~dp0ruby.exe" "%~dpn0" %*

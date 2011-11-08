echo "Starting build";

tools\nant\nant.exe -buildfile:PhotoX.build -logfile:NantBuild.log

PAUSE;
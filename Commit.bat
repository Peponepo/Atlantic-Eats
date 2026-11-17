@echo off
cd GodotUtils
set /p utils_commit="GodotUtils commit msg: "
if defined utils_commit (
git add .
git commit -m "%utils_commit%"
pause
git push
)
set /p veil_commit="Atlantica commit msg: "
if defined veil_commit (
cd ..
git add .
git commit -m "%veil_commit%"
pause
git push
)
echo  |
echo  |
echo \/
echo Commit Done!!
pause


@echo off
cd %~dp0
git add -A
git commit -a --allow-empty-message -m ""
git push origin master
ssh root@ali.sharonlee.top -p 31415 "cd /root/nginx/html/notes/ && git pull"
git push github master
if %errorlevel% neq 0 (
  pause
  exit /b %errorlevel%
)
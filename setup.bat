@echo off
chcp 65001
title 安装右键菜单

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4F
    echo ======================================
    echo 错误：需要管理员权限！
    echo 请右键点击此文件，选择"以管理员身份运行"
    echo ======================================
    pause
    exit /b 1
)

:: 检查必要文件
if not exist "%~dp0FolderCreator.exe" (
    color 4F
    echo ======================================
    echo 错误：未找到FolderCreator.exe文件！
    echo 请确保FolderCreator.exe与此脚本在同一目录下。
    echo ======================================
    pause
    exit /b 1
)

:: 清理旧的注册表项
echo 正在清理旧的注册表项...
reg delete "HKEY_CLASSES_ROOT\Directory\shell\BatchCreateFolders" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\CreateDocFolders" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\DocFolders" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\ImportDocFolders" /f >nul 2>&1

echo 正在安装右键菜单...

:: 创建右键菜单项
reg add "HKEY_CLASSES_ROOT\Directory\shell\批量创建文件夹" /ve /d "创建跟单文件夹" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\批量创建文件夹" /v "Icon" /d "%SystemRoot%\System32\shell32.dll,3" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\批量创建文件夹\command" /ve /d "\"%~dp0FolderCreator.exe\" \"%%1\"" /f

if %errorlevel% equ 0 (
    color 2F
    echo ======================================
    echo 安装成功！
    echo.
    echo 现在您可以在文件夹上右键点击，
    echo 选择"创建跟单文件夹"来使用此功能。
    echo.
    echo 此功能将创建以下子文件夹：
    echo  1.PI
    echo  2.采购合同
    echo  3.码单
    echo  4.进仓申请
    echo  5.单证资料
    echo  6.装柜图片
    echo  7.客户发票
    echo  8.信保资料
    echo  9.开票通知
    echo ======================================
) else (
    color 4F
    echo ======================================
    echo 安装失败，错误代码：%errorlevel%
    echo 请确保以管理员身份运行此脚本。
    echo ======================================
)

echo 按任意键退出...
pause > nul

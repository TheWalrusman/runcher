# Remember to execute this from the root of RPFM's git folder.
Set-Variable -Name "RUNCHER_PATH" -Value ((Get-Location).path)
Set-Variable -Name "RUNCHER_VERSION" -Value (Select-String -Path Cargo.toml -Pattern '^version = \"(.*)\"$').Matches.Groups[1].value

# Build the tools.
cargo build --release

# Prepare the paths for the deployment.
Set-Location E:\
Remove-Item -r -fo E:\deploy
mkdir deploy
Set-Location deploy
mkdir runcher-release-assets
Set-Location runcher-release-assets

# Copy Breeze icons into the release.
mkdir -p data/icons
Copy-Item "C:\CraftRoot\bin\data\icons\breeze" "E:\deploy\runcher-release-assets\data\icons\" -recurse
Copy-Item "C:\CraftRoot\bin\data\icons\breeze-dark" "E:\deploy\runcher-release-assets\data\icons\" -recurse

# Here we copy all the dlls required by runcher. Otherwise we'll have to manually update them on every freaking release, and for 2 months that's been a royal PITA.
mkdir designer
Copy-Item C:\CraftRoot\plugins\designer\*.dll E:\deploy\runcher-release-assets\designer\

mkdir iconengines
Copy-Item C:\CraftRoot\plugins\iconengines\KIconEnginePlugin.dll E:\deploy\runcher-release-assets\iconengines\
Copy-Item C:\CraftRoot\plugins\iconengines\qsvgicon.dll E:\deploy\runcher-release-assets\iconengines\

mkdir imageformats
Copy-Item C:\CraftRoot\plugins\imageformats\*.dll E:\deploy\runcher-release-assets\imageformats\

mkdir platforms
Copy-Item C:\CraftRoot\plugins\platforms\qwindows.dll E:\deploy\runcher-release-assets\platforms\

mkdir styles
Copy-Item C:\CraftRoot\plugins\styles\qwindowsvistastyle.dll E:\deploy\runcher-release-assets\styles\

Copy-Item C:\CraftRoot\bin\d3dcompiler_47.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\dbus-1-3.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\editorconfig.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\freetype.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\harfbuzz.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\iconv.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\icudt??.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\icuin??.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\icuuc??.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\intl-8.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\jpeg62.dll E:\deploy\runcher-release-assets\

Copy-Item C:\CraftRoot\bin\KF5Archive.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5Codecs.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5ConfigCore.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5ConfigGui.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5ConfigWidgets.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5CoreAddons.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5GuiAddons.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5I18n.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5IconThemes.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\KF5WidgetsAddons.dll E:\deploy\runcher-release-assets\

Copy-Item C:\CraftRoot\bin\libbzip2.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\libcrypto*.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\libEGL.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\libGLESV2.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\liblzma.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\libpng16.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\libssl*.dll E:\deploy\runcher-release-assets\

# Are these still neccesary?
Copy-Item C:\CraftRoot\bin\msvcp140.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\msvcp140_1.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\msvcp140_2.dll E:\deploy\runcher-release-assets\

Copy-Item C:\CraftRoot\bin\pcre2-8.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\pcre2-16.dll E:\deploy\runcher-release-assets\

Copy-Item C:\CraftRoot\bin\Qt5DBus.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\Qt5Svg.dll E:\deploy\runcher-release-assets\

# Same as before. Still neccesary?
Copy-Item C:\CraftRoot\bin\vcruntime140.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\vcruntime140_1.dll E:\deploy\runcher-release-assets\

Copy-Item C:\CraftRoot\bin\tiff.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\zlib1.dll E:\deploy\runcher-release-assets\
Copy-Item C:\CraftRoot\bin\zstd.dll E:\deploy\runcher-release-assets\

# Here we copy files generated from the compilation.
Copy-Item $RUNCHER_PATH/target/release/runcher.exe E:\deploy\runcher-release-assets
Copy-Item $RUNCHER_PATH/target/release/runcher.pdb E:\deploy\runcher-release-assets

# Workshopper for workshop and steam launch support.
Copy-Item $RUNCHER_PATH/workshopper/3rdparty/steam_api64.dll E:\deploy\runcher-release-assets
Copy-Item $RUNCHER_PATH/target/release/workshopper.exe E:\deploy\runcher-release-assets

# TWPatcher for load order patching support.
Copy-Item $RUNCHER_PATH/target/release/twpatcher.exe E:\deploy\runcher-release-assets

# Here we copy assets from the repo.
mkdir icons
mkdir locale
mkdir ui
Copy-Item $RUNCHER_PATH/LICENSE E:\deploy\runcher-release-assets
Copy-Item $RUNCHER_PATH/CHANGELOG.md E:\deploy\runcher-release-assets
Copy-Item $RUNCHER_PATH/CHANGELOG.md E:\deploy\runcher-release-assets\CHANGELOG.txt
Copy-Item $RUNCHER_PATH/dark-theme.qss E:\deploy\runcher-release-assets
Copy-Item $RUNCHER_PATH/icons/* E:\deploy\runcher-release-assets\icons\
Copy-Item $RUNCHER_PATH/locale/* E:\deploy\runcher-release-assets\locale\
Copy-Item $RUNCHER_PATH/ui_templates/* E:\deploy\runcher-release-assets\ui\

# Execute windeployqt to add missing translations and the vcredist if needed.
windeployqt runcher.exe

# Remove extra files that are not really needed for execution.
Remove-Item -fo E:\deploy\runcher-release-assets\vc_redist.x64.exe
Remove-Item -fo E:\deploy\runcher-release-assets\icons\breeze-icons.rcc
Remove-Item -fo E:\deploy\runcher-release-assets\icons\breeze-icons-dark.rcc

Set-Location E:\deploy
7z a runcher-v$RUNCHER_VERSION-x86_64-pc-windows-msvc.zip .\**

# Move back to the original folder.
Set-Location $RUNCHER_PATH

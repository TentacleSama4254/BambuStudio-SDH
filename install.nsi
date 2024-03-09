; The name of the installer
Name "BambuStudio_SDH"

; To change from default installer icon:
;Icon "BambuStudio_SDH.ico"

; The setup filename
OutFile "BambuStudio_SDH_Setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\BambuStudio_SDH

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\BambuStudio_SDH" "Install_Dir"

; RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "BambuStudio_SDH (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there (you can add more File lines too)
;   File "BambuStudio_SDH.exe"
  ; Wildcards are allowed:
  ; File *.dll
  ; To add a folder named MYFOLDER and all files in it recursively, use this EXACT syntax:
  File /r install_dir\*.*
  ; See: https://nsis.sourceforge.io/Reference/File
  ; MAKE SURE YOU PUT ALL THE FILES HERE IN THE UNINSTALLER TOO
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\BambuStudio_SDH "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\BambuStudio_SDH" "DisplayName" "BambuStudio_SDH"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\BambuStudio_SDH" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\BambuStudio_SDH" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\BambuStudio_SDH" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts (required)"
  SectionIn RO

  CreateDirectory "$SMPROGRAMS\BambuStudio_SDH"
  CreateShortcut "$SMPROGRAMS\BambuStudio_SDH\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\BambuStudio_SDH\BambuStudio_SDH.lnk" "$INSTDIR\BambuStudio_SDH.exe" "" "$INSTDIR\BambuStudio_SDH.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\BambuStudio_SDH"
  DeleteRegKey HKLM SOFTWARE\BambuStudio_SDH

  ; Remove files and uninstaller
  ; MAKE SURE NOT TO USE A WILDCARD. IF A
  ; USER CHOOSES A STUPID INSTALL DIRECTORY,
  ; YOU'LL WIPE OUT OTHER FILES TOO
  Delete $INSTDIR\BambuStudio_SDH.exe
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\BambuStudio_SDH\*.*"

  ; Remove directories used (only deletes empty dirs)
  RMDir "$SMPROGRAMS\BambuStudio_SDH"
  RMDir "$INSTDIR"

SectionEnd
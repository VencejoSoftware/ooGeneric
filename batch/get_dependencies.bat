@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning dxDUnit..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)
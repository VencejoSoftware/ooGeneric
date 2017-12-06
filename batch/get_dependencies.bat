@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning ooBatch..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphi3rdParty%\generics.collections\ (
  @echo "Clonning generics.collections..."
  git clone https://github.com/VencejoSoftware/generics.collections.git %delphi3rdParty%\generics.collections\
)
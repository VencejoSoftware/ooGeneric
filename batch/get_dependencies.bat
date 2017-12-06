@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning ooBatch..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %path_3rd_party%\generics.collections\ (
  @echo "Clonning generics.collections..."
  git clone https://github.com/VencejoSoftware/generics.collections.git %path_3rd_party%\generics.collections\
)
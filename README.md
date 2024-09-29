# PrizmSDK

This repository includes the packed PrizmSDK for x86_64 Linux and PrizmSDK source code. They are available in release page.

## Build Yourself

First, clone all the PrizmSDK files.

```bash
git clone https://github.com/TabNahida/PrizmSDK.git
cd PrizmSDK
git clone https://github.com/Jonimoose/libfxcg.git
git clone https://gitlab.com/taricorp/mkg3a.git
```
Second, choose a version of ``binutils`` and ``gcc``. Download their source file to the PrizmSDK folder. Here I will take the last version as an example.

```bash
git clone git://gcc.gnu.org/git/gcc.git
git clone git://sourceware.org/git/binutils-gdb.git
```

Last, run the script ``build.sh``

```bash
chmod +x build.sh
./build.sh
```

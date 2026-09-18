# Laboratory Work No. 2

**Subject:** Determination of properties of an operating system. Operation with files and directories.

**Purpose:** Acquisition of the main skills of operation in the environment of the MS-DOS operating system.

**Variant: 6**

## Short theoretical background

An operating system (OS) provides the user and application programs with an interface to the computer's devices, accepts commands and executes them. MS-DOS (MicroSoft Disk Operating System) consists of BIOS, the `io.sys` and `msdos.sys` files, the `command.com` command processor, as well as drivers and the `config.sys` / `autoexec.bat` files.

### MS-DOS commands used

**Service commands**

| Command | Purpose |
|---|---|
| `VER` | display the MS-DOS version |
| `CLS` | clear the screen |
| `DATE` | request the current date |
| `TIME` | request the current time |

**Navigation across disks and directories**

| Command | Purpose |
|---|---|
| `DriveName:` | change the current drive (e.g. `D:`) |
| `CD DirectoryPath` | change to the specified directory |
| `CD ..` | move to the parent directory |
| `CD \` | move to the root directory of the current drive |

**File operations**

| Command | Purpose |
|---|---|
| `REN OldName NewName` | rename a file |
| `TYPE FileName` | view file contents |
| `EDIT FileName` | edit a file |
| `COPY SourceFile CopyFile` | copy a file |
| `COPY FileName PRN` | print a file |
| `MOVE FileName DirectoryPath` | move a file |
| `DEL FileName` | delete a file |
| `COPY CON FileName` (type text, finish with `F6`/`Ctrl+Z`) | create a new text file from the keyboard |

**Directory operations**

| Command | Purpose |
|---|---|
| `DIR [DirectoryPath] [/P]` | view directory contents (`/P` — page by page) |
| `MD DirectoryName` | create a new directory |
| `MOVE OldName NewName` | rename a directory |
| `RD DirectoryName` | delete an empty directory (the current directory cannot be deleted — move to the parent first) |

## Task (Variant 6)

Create the following hierarchical file system inside the `STUDENT` directory:

```
C:\STUDENT
├── D1 (d1.txt)
│   └── D2 (d2.txt)
│       ├── D3 (d3.txt)
│       ├── D4 (d4.txt)
│       └── D5 (d5.txt)
└── D6 (d6.txt)
    └── D7 (d7.txt)
        └── D8 (d8.txt)
```

`D1` and `D6` are two independent subdirectories of `STUDENT`. `D1` contains only `D2`, which in turn contains `D3`, `D4`, `D5`. The `D6` branch is a chain of nested directories: `D6` → `D7` → `D8` (each next directory is nested inside the previous one, not a "sibling" of it).

Each directory `D1`–`D8` contains a text file of the same name (`d1.txt`–`d8.txt`).

## Solution — sequence of MS-DOS commands

```dos
C:\>MD STUDENT
C:\>CD STUDENT

C:\STUDENT>MD D1
C:\STUDENT>CD D1
C:\STUDENT\D1>COPY CON d1.txt
D1 directory file
^Z

C:\STUDENT\D1>MD D2
C:\STUDENT\D1>CD D2
C:\STUDENT\D1\D2>COPY CON d2.txt
D2 directory file
^Z

C:\STUDENT\D1\D2>MD D3
C:\STUDENT\D1\D2>CD D3
C:\STUDENT\D1\D2\D3>COPY CON d3.txt
D3 directory file
^Z
C:\STUDENT\D1\D2\D3>CD ..

C:\STUDENT\D1\D2>MD D4
C:\STUDENT\D1\D2>CD D4
C:\STUDENT\D1\D2\D4>COPY CON d4.txt
D4 directory file
^Z
C:\STUDENT\D1\D2\D4>CD ..

C:\STUDENT\D1\D2>MD D5
C:\STUDENT\D1\D2>CD D5
C:\STUDENT\D1\D2\D5>COPY CON d5.txt
D5 directory file
^Z
C:\STUDENT\D1\D2\D5>CD ..
C:\STUDENT\D1\D2>CD ..
C:\STUDENT\D1>CD ..

C:\STUDENT>MD D6
C:\STUDENT>CD D6
C:\STUDENT\D6>COPY CON d6.txt
D6 directory file
^Z

C:\STUDENT\D6>MD D7
C:\STUDENT\D6>CD D7
C:\STUDENT\D6\D7>COPY CON d7.txt
D7 directory file
^Z

C:\STUDENT\D6\D7>MD D8
C:\STUDENT\D6\D7>CD D8
C:\STUDENT\D6\D7\D8>COPY CON d8.txt
D8 directory file
^Z

C:\STUDENT\D6\D7\D8>CD \
C:\>
```

### Verifying the result

The following command is used to review the built directory tree page by page:

```dos
C:\>CD STUDENT
C:\STUDENT>DIR /S /P
```

The `DIR /S` command recursively lists the contents of the `STUDENT` directory and all its nested subdirectories `D1`–`D8`, confirming that the structure and files (`d1.txt`–`d8.txt`) were created according to the assigned variant.

## Conclusion

This laboratory work covered the core MS-DOS commands: service commands (`VER`, `CLS`, `DATE`, `TIME`), navigation commands (`CD`, drive switching), file commands (`COPY CON`, `TYPE`, `REN`, `DEL`, `MOVE`), and directory commands (`MD`, `RD`, `DIR`). These were used to build the hierarchical file structure of the `STUDENT` directory assigned for variant 6.

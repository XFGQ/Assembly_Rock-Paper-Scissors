# Rock-Paper-Scissors (Assembly)

This is a simple Rock-Paper-Scissors game written in Assembly language. You play against the computer in the terminal. After each round, you’ll see who won and why.

---

- [What is this project?](#what-is-this-project)
- [What do you need to run it?](#what-do-you-need-to-run-it)
- [How to run on Linux](#how-to-run-on-linux)
- [How to run on Windows](#how-to-run-on-windows)
- [How to run on macOS](#how-to-run-on-macos)
- [How to play](#how-to-play)

---

## What is this project?

This is a terminal-based game where you choose Rock (0), Paper (1), or Scissors (2), and the computer randomly picks one too. Then the result is shown with a short explanation like:

```
Rock beats Scissors — You win!
```

---

## What do you need to run it?

The required tools depend on your operating system:

| Platform | Tools Required |
|----------|----------------|
| Linux    | NASM + GCC |
| Windows  | NASM + MinGW (for GCC) |
| macOS    | NASM + `ld` or `clang` (and 32/64-bit support) |

---

## How to run on Linux

> 💡 File to use: `rock_paper_scissors_linux.asm`

1. Install NASM and GCC:
```bash
sudo apt update
sudo apt install nasm gcc
```

2. Compile and run:
```bash
nasm -f elf32 rock_paper_scissors_linux.asm -o rps.o
gcc -m32 rps.o -o rps
./rps
```

> 🧠 If you are on a 64-bit system, install multilib support:
```bash
sudo apt install gcc-multilib
```

---

## How to run on Windows

> 💡 File to use: `rock_paper_scissors_win.asm`

1. Download and install:
   - [NASM](https://www.nasm.us/pub/nasm/releasebuilds/)
   - [MinGW](https://sourceforge.net/projects/mingw/) (provides GCC)

2. Open **Command Prompt**, go to your project folder:
```cmd
cd path\to\your\project
```

3. Compile and run:
```cmd
nasm -f win32 rock_paper_scissors_win.asm -o rps.obj
gcc rps.obj -o rps.exe -m32
rps.exe
```

> ⚠️ Make sure you install the **32-bit version of GCC** with MinGW.

---

## How to run on macOS

> 💡 File to use: `rock_paper_scissors_macos.asm`

1. Install NASM:
```bash
brew install nasm
```

2. Compile and link:
```bash
nasm -f macho64 rock_paper_scissors_macos.asm -o rps.o
ld -macosx_version_min 10.7.0 -lSystem -o rps rps.o
```

> ❗ If `ld` gives an error, try using `clang` instead.

3. Run the game:
```bash
./rps
```

---

## How to play

1. The game will ask:
```
Enter your choice (0: Rock, 1: Paper, 2: Scissors):
```

2. Then it shows:
```
Your choice is: Rock
Computer's choice is: Scissors
Rock beats Scissors — You win!
```

3. Then you can play again or close the terminal.

---

## File Summary

| File Name                        | Description                       |
|----------------------------------|-----------------------------------|
| rock_paper_scissors_linux.asm   | Works on Linux with `int 0x80`    |
| rock_paper_scissors_win.asm     | Works on Windows using C calls    |
| rock_paper_scissors_macos.asm   | Works on macOS using `syscall`    |

---

## Author

This project was developed as part of an Assembly language learning exercise.  
Feel free to use, modify, or improve!

---

Have fun! 🎮

# Rock-Paper-Scissors (Assembly)

This is a simple Rock-Paper-Scissors game written in Assembly language. You play against the computer in the terminal. After each round, you’ll see who won and why.

---

- [What is this project?](#what-is-this-project)
- [What do you need to run it?](#what-do-you-need-to-run-it)
- [How to run on Windows](#how-to-run-on-windows)
- [How to run on Linux](#how-to-run-on-linux)
- [How to run on macOS](#how-to-run-on-macos)
- [How to play](#how-to-play)

---

## What is this project?

This is a terminal-based game where you choose Rock (1), Paper (2), or Scissors (3), and the computer randomly picks one too. Then the result is shown with a short explanation like “Rock beats Scissors – You win!”

---

## What do you need to run it?

You only need to install [NASM (Netwide Assembler)](https://www.nasm.us/pub/nasm/releasebuilds/) and a C compiler like `gcc`.

---

## How to run on Windows

1. Download and install NASM from here:  
   👉 https://www.nasm.us/pub/nasm/releasebuilds/

2. Install [MinGW](https://sourceforge.net/projects/mingw/) to get `gcc`.

3. Open Command Prompt and go to your project folder:

```bash
cd path\to\your\project
```

4. Compile and run:

```bash
nasm -f win32 rock_paper_scissors.asm -o rock_paper_scissors.obj
gcc rock_paper_scissors.obj -o rock_paper_scissors.exe
rock_paper_scissors.exe
```

---

## How to run on Linux

1. Open a terminal and install NASM and GCC:

```bash
sudo apt update
sudo apt install nasm gcc
```

2. Go to your project folder and run:

```bash
cd path/to/your/project
nasm -f elf32 rock_paper_scissors.asm -o rock_paper_scissors.o
gcc -m32 rock_paper_scissors.o -o rock_paper_scissors
./rock_paper_scissors
```

> 💡 If you're on a 64-bit system, you may need to enable 32-bit support:  
> `sudo apt install gcc-multilib`

---

## How to run on macOS

1. Install [Homebrew](https://brew.sh/) if you don't have it.

2. Then install NASM and GCC:

```bash
brew install nasm gcc
```

3. Open Terminal, go to your project folder, and run:

```bash
cd path/to/your/project
nasm -f macho32 rock_paper_scissors.asm -o rock_paper_scissors.o
gcc -m32 rock_paper_scissors.o -o rock_paper_scissors
./rock_paper_scissors
```

> 🧠 Note: You may need extra steps for 32-bit support on newer macOS versions.

---

## How to play

1. When the game starts, you’ll see a menu:
   - Press `1` for Rock  
   - Press `2` for Paper  
   - Press `3` for Scissors  

2. The result will be shown like:

```text
You chose Rock.
Computer chose Scissors.
Rock beats Scissors — You win!
```

3. After that, you can play again or quit.

---

## Author

This project was developed as part of an Assembly language learning exercise.  
Feel free to use, modify, or improve!

---

Have fun! 🎮

# 📘 CFG Parser Tree (Context-Free Grammar Tree Visualizer)

A simple Flutter app that allows you to **build, parse, and visualize a derivation tree** from a given **Context-Free Grammar (CFG)**. This tool is especially helpful for students learning **Automata Theory**, **Compilers**, or **Formal Languages**.

---

## ✨ Features

- Add non-terminals, terminals, and production rules
- Input your own CFG and start symbol
- Parse and build the **derivation tree**
- View the result as a **text-based parse tree**
- Clean interface built with **Flutter**

---

## 📱 Screenshots

> ✅ Coming soon: You can insert screenshots here showing the input form and output parse tree.

---

## 🧠 Sample Usage

### Given CFG:

```
Non-Terminals: S, A
Terminals: a, b
Start Symbol: S

Productions:
S -> aA | b
A -> b

```

### Resulting Parse Tree (for `S -> aA`, `A -> b`):

```
S
├─ a
└─ A
└─ b

```

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/darknecrocities/CFG-parser-tree.git
cd CFG-parser-tree

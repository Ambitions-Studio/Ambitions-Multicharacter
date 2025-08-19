# 🧍 Ambitions Multicharacter — Seamless Character Management for Ambitions Framework

![GitHub License](https://img.shields.io/badge/license-LGPL%203.0-blue.svg)
![FiveM](https://img.shields.io/badge/FiveM-Character%20System-critical)
![Lua 5.4](https://img.shields.io/badge/Lua-5.4-lightgrey)
![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)

---

## 📚 Documentation

Configuration, integration examples, and extension guides are available on the main documentation portal:

👉 [**Ambitions Documentation**](https://ambitions.gitbook.io/ambitions-documentation)

---

## 🔎 What is Ambitions Multicharacter?

**Ambitions Multicharacter** is the official multicharacter module for the [Ambitions Framework](https://github.com/Ambitions-Studio/Ambitions).  
It provides a fully customizable and modular system for managing player characters across multiple slots — including identity registration and appearance setup.

Built with Lua 5.4 standards and the same philosophy of structure, clarity and performance.

---

## ⚡ Key Features

- 🧠 **Slot-Based Character System** — Define how many characters each player can create  
- 🪪 **Built-in Identity Creation** — First-time registration handled directly within the module
- 🧍 **Appearance Workflow** — Setup includes face, model, clothing, and more
- 🎨 **Premium In-House UI** — Clean, modern and fully integrated UI designed specifically for Ambitions  
- 🔌 **Modular Integration** — Hooks into the Ambitions framework lifecycle, with shared API exports  
- ♻️ **Clean Separation** — Each character is sandboxed (separate job, inventory, bank, housing, etc.)  
- 🎨 **UI-Agnostic Logic** — Back-end first design: you’re free to use any UI system (NUI, JS, etc.) 

---

## ⚙️ Requirements

| Requirement              | Version / Note                    |
|--------------------------|------------------------------------|
| **Ambitions Framework**  | Latest stable version             |
| **Database**             | MariaDB & SQL                     |
| **FiveM Artifact**       | 12208+ recommended                |

---

## 🚀 Quick Start

```bash
git clone https://github.com/Ambitions-Studio/Ambitions-Multicharacter.git
# Move to your resources directory and start after 'ambitions-core'
```

In your `server.cfg`:

```cfg
ensure ambitions-core
ensure ambitions-multicharacter
```

Configure character slots and logic inside the provided `config.lua`.

---

## 🤝 Contribute

We welcome community contributions!

- 🧠 Propose ideas or enhancements  
- 🐞 Report bugs via Issues tab  
- 🧱 Submit PRs (structure must follow Ambitions conventions)

Please review the [`CONTRIBUTING.md`](./CONTRIBUTING.md) for style and commit rules.

---

## 📜 License

Ambitions Multicharacter is licensed under **LGPL 3.0**.  
You’re free to use, modify, and distribute under the license terms.

---

## 💬 Questions?

Open an issue or start a discussion — the team is actively building this ecosystem and your feedback matters.

---

🎯 **Ambitions Multicharacter is more than a character selector.  
It’s the identity backbone of serious RP servers and the foundation of your characters' lives.**

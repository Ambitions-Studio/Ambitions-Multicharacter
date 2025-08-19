# 🤝 Contributing to Ambitions Multicharacter

We welcome and appreciate all contributions to **Ambitions Multicharacter** — whether it’s bug fixes, feature enhancements, optimizations, or ideas for improvement. This document outlines the best practices and rules to follow when contributing to ensure quality and consistency.

---

## 🧭 Contribution Philosophy

- **Integrated Design First** – This module follows Ambitions’ modular architecture and coding standards.
- **Clean + Maintainable** – Contributions should be simple, modular, and well-documented.
- **User-Focused** – Every change should improve the experience, performance, or clarity for developers and players.

---

## ✅ Do

- Follow **Lua 5.4** standards (constants, annotations, local scoping, etc.)
- Use the Ambitions naming conventions (`camelCase`, `PascalCase`, `SNAKE_CASE` for constants)
- Keep your code **pure**, **single-responsibility**, and **reusable**
- Document every function using annotations (`---@param`, `---@return`, etc.)
- Keep nesting shallow (preferably no more than 3 levels deep)
- Test your features thoroughly (especially UI or spawn logic)
- Use clear and structured commit messages (see below)

---

## ❌ Don’t

- Push directly to `main`
- Submit code with debug prints, test values, or leftover data
- Mix unrelated features in one PR (stick to one purpose per PR)
- Introduce UI or identity-breaking changes without proper fallback
- Assume dependencies from outside the Ambitions ecosystem

---

## 📦 Local Setup

```bash
git clone https://github.com/Ambitions-Studio/Ambitions-Multicharacter.git
# Move to your resources folder
# Ensure it's started after ambitions-core in your server.cfg
```

Ensure your testing environment is configured with:
- A working Ambitions Core setup
- MariaDB database (not XAMPP)
- FiveM artifact build 12208 or higher

---

## 🔀 Creating a Pull Request

1. Fork the repository
2. Create a feature branch:
   ```sh
   git checkout -b feat/your-feature-name
   ```
3. Make your changes and test locally
4. Commit with clear messages:
   ```sh
   git commit -m "feat(ui): added fade transition when switching characters"
   ```
5. Push to your fork:
   ```sh
   git push origin feat/your-feature-name
   ```
6. Open a Pull Request targeting the `dev` branch

Your PR will be reviewed by a maintainer. We may request changes before merging to ensure consistency.

---

## 🧪 Suggested Tools

- **Luacheck** – Recommended for linting and catching simple Lua mistakes
- **FiveM Console** – Useful for inspecting logs during spawn/character flows
- **JSON Validator** – If you work with UI configs or character data in JSON
- **Video Recording** – Helps document UI changes or user experience flows in PRs

---

## 🐞 Reporting Bugs

If you encounter a bug or issue:

- Check that it hasn’t already been reported
- Use the **bug report template**
- Provide clear steps to reproduce
- Include any relevant logs or screenshots

The more detailed your report, the faster we can fix it.

---

## 📜 Licensing

All contributions are subject to the same license as the main project: **LGPL 3.0**.  
By contributing, you agree that your code can be included and distributed under this license.

---

Thanks for helping shape Ambitions Multicharacter —  
A better character system for a better RP experience. 💙

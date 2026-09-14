# Pi-Mage

---

## Introduction

Pi-Mage is a purpose-built development container and automation platform that brings together the **Pi Coding Agent** ecosystem with **LiteLLM proxy capabilities**, creating a powerful, self-contained workspace for developers, researchers, and AI automation engineers.

The container architecture follows the **principle of least privilege**:

1. **Minimal Base Image**: `library/debian:forky-20260824-slim` provides a small, up-to-date Linux base.
2. **Privilege Removal**: All binaries that could lead to privilege escalation or container escapes are explicitly removed.
3. **SUID/SGID Cleanup**: All setuid/setgid files are stripped of special permissions to prevent privilege escalation.
4. **Dedicated User**: A non-root user `worker` is created for all runtime operations.
5. **Git Sanitization**: Git trace and curl verbose flags are stripped to prevent information leakage.

---

## AI Disclosure

> **Important Notice:** This README.md was authored and written by **AI (Large Language Model)** assistance. The documentation, section structure, technical explanations, and user-facing content were generated automatically to ensure accuracy, clarity, and completeness.
>
> **The Dockerfile and build script have NOT been modified by AI.** They represent the original, human-authored implementation of the Pi-Mage project and remain fully auditable and trusted.
>
> All code in this repository was written by human developers and contributors. The README.md serves as a generated documentation layer and is intended to complement — not replace — human-authored documentation. Anyone using this project should verify Dockerfile instructions against the source code and maintain their own understanding of the security and operational characteristics.

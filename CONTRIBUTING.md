# Contributing to **Hamsafar**

> ✨ **Welcome!** This document explains how we develop Hamsafar so you can contribute with confidence.

---

## 📌 Quick Project Snapshot

| Layer        | Tech             |
| ------------ | ---------------- |
| **Mobile**   | Flutter / Dart   |
| **Backend**  | FastAPI / Python |
| **Database** | MongoDB          |
| **CI/CD**    | GitLab Pipelines |

---

## 🗂️ Kanban Board

We track work on the GitLab **Issue Board**: [https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/boards](https://gitlab.pg.innopolis.university/d.chegaev/shareyourride/-/boards)

| Column          | When a card lives here                             |
| --------------- | -------------------------------------------------- |
| **Backlog**     | Idea captured but not yet prioritised              |
| **To Do**       | Task selected for the next sprint / ready to start |
| **In Progress** | Actively being developed                           |
| **Done**        | Merged to `main`, pipeline green                   |

*Definition of Done:* merged, tests pass, no new warnings, issue closed.

---

## 🔄 Git Workflow

### Branching model

| Branch           | Purpose                             |
| ---------------- | ----------------------------------- |
| `main`           | Always deploy‑able, tagged releases |
| `feature/<slug>` | New feature or refactor             |
| `fix/<slug>`     | Bugfix                              |

> **Tip:** use short, kebab‑case slugs, e.g. `feature/driver-rating`.

### Commit messages

Write in **imperative mood**. Prefixes (`feat:`, `fix:`, `docs:` …) are **welcome but optional**. Examples:

```
feat: add driver rating screen
Fix crash on empty phone number
```

### Issues & Labels

1. Create issues using templates in `.gitlab/issue_templates`.
2. Add labels for type (`task`, `bug`, `user story`) and priority (`P0`, `P1`, `P2`).
3. Assign yourself when you start work.
4. Close the issue manually after merge.

### Merge Requests (MR)

* One MR ⇔ one issue.
* Fill in the MR template — include **What / Why / How to test**.
* At least **1 approval** required.
* **Pipeline must be green**.
* Use **Squash & merge** into `main`.

---

## 🔐 Secrets Management

| Environment | Where secrets live                         |
| ----------- | ------------------------------------------ |
| **Local**   | `project_settings.yaml` **ignored by Git** |
| **CI/CD**   | GitLab **Settings → CI/CD → Variables**    |

Never commit keys, tokens or passwords. If you accidentally push one, **revoke it immediately** and inform the maintainer.

---

## 🧪 Tests & CI

| Stage             | Tool                      |
| ----------------- | ------------------------- |
| **Lint (Py)**     | `pycodestyle`             |
| **Unit / Int**    | `pytest` (backend)        |
| **Widget / Unit** | `flutter test` (frontend) |

CI config lives in `.gitlab-ci.yml`. The MR will not merge until all jobs pass.

---

## ✅ Pre‑merge Checklist

* [ ] Code compiles & runs locally
* [ ] Tests added or updated, all passing
* [ ] No secrets committed
* [ ] Commit messages follow the style
* [ ] MR description filled, pipeline green, reviewer approved

Thank you for contributing! Together we move faster 🚗💨

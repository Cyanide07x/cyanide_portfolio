# CYNX Folio

> Design and code, out of phase on purpose.

**CYNX Folio** is my personal portfolio website, built to showcase my work, projects, skills, and creative experiments through a minimal, interactive interface.

🌐 **Live:** https://cyanide07x.github.io/cyanide_portfolio/

---

## ✦ About

CYNX Folio is a personal portfolio built with **Flutter Web**.

The goal was to create something that feels less like a traditional developer portfolio and more like a digital space that reflects my interests in:

- Development
- UI/UX
- Visual design
- Creative experimentation
- Interactive web experiences

---

## ⚡ Features

- Responsive design for desktop, tablet, and mobile
- Animated CYNX landing page
- Interactive navigation
- Responsive project showcase
- About section
- Contact form
- Discord contact integration
- Resume access
- LinkedIn and GitHub links
- Smooth page transitions
- Interactive visual elements
- Custom CYNX branding
- GitHub Pages deployment

---

## 🛠 Tech Stack

### Frontend

- Flutter
- Dart
- Flutter Web

### Packages

- `flutter_svg`
- `url_launcher`
- `http`
- Google Fonts

### Tools

- Visual Studio Code
- Git
- GitHub
- GitHub Actions

---

## 📁 Project Structure

```text
cyanide_portfolio/
│
├── assets/
│   └── images/
│       ├── logos/
│       │   ├── cynx_logo.svg
│       │   ├── cynx_mark.svg
│       │   └── corner_decorations.svg
│       │
│       └── resume/
│           └── Utsav_Sachan_Resume_cynx.pdf
│
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   │
│   ├── screens/
│   │   ├── intro/
│   │   ├── home/
│   │   ├── work/
│   │   ├── about/
│   │   └── contact/
│   │
│   └── widgets/
│       └── common/
│
├── web/
│   ├── index.html
│   ├── manifest.json
│   ├── favicon.svg
│   └── ...
│
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
└── .gitignore
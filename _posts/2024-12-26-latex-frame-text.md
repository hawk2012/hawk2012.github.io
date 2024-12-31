---
layout: default
title: Создание текста в рамке latex
permalink: /latex-frame-text/
---

Для создания текста в рамке в LaTeX используется пакет `fancybox`. Вот пример кода:

```latex
\documentclass{article}
\usepackage{fancybox}
\begin{document}

\fbox{
  \begin{minipage}{0.9\textwidth}
    Ваш текст внутри рамки.
  \end{minipage}
}

\end{document}
```

В этом коде:
- Пакет `fancybox` подключается командой `\usepackage{fancybox}`.
- Команда `\fbox{}` создает рамку вокруг содержимого.
- Внутри `\fbox{}` используется окружение `minipage`, чтобы ограничить ширину текста и обеспечить правильное центрирование.

Вы можете изменить параметры ширины `minipage` (`0.9\textwidth`) для настройки размера рамки относительно страницы.
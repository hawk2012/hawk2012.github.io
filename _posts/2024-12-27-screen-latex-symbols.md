---
layout: default
title: Экранирование символов latex
permalink: /screen-latex-symbols/
---

В LaTeX экранировать специальные символы необходимо для того, чтобы они выводились в тексте документа корректно. Некоторые символы имеют особое значение в синтаксисе LaTeX, поэтому их нужно экранировать, если вы хотите использовать эти символы буквально.

Вот список наиболее часто используемых специальных символов и способы их экранирования:

1. **%** — используется для комментариев. Чтобы вывести символ `%`, нужно написать `\%`.
   
   ```latex
   \documentclass{article}
   \begin{document}
   This is a percentage sign: \%
   \end{document}
   ```

2. **$** — используется для начала и конца математических выражений. Чтобы вывести `$` в тексте, нужно написать `\$`.
   
   ```latex
   \documentclass{article}
   \begin{document}
   The dollar sign is: \$
   \end{document}
   ```

3. **&** — используется для разделения колонок в таблицах. Чтобы вывести `&` в тексте, нужно написать `\&`.
   
   ```latex
   \documentclass{article}
   \begin{document}
   An ampersand looks like this: \&
   \end{document}
   ```

4. **#** — используется для передачи аргументов командам. Чтобы вывести `#` в тексте, нужно написать `\#`.
   
   ```latex
   \documentclass{article}
   \begin{document}
   A hash symbol is: \#
   \end{document}
   ```

5. **_** — используется для подстрочных индексов в математике. Чтобы вывести `_` в тексте, нужно написать `\_`.
   
   ```latex
   \documentclass{article}
   \begin{document}
   An underscore looks like this: \_
   \end{document}
   ```

6. **^** — используется для надстрочных индексов в математике. Чтобы вывести `^` в тексте, нужно написать `\^{}` (пустой аргумент необходим).
   
   ```latex
   \documentclass{article}
   \begin{document}
   A caret symbol is: \^{}
   \end{document}
   ```

7. **~** — используется для неразрывного пробела. Чтобы вывести `~` в тексте, нужно написать `\~{}` (пустой аргумент необходим).
   
   ```latex
   \documentclass{article}
   \begin{document}
   A tilde symbol is: \~{}
   \end{document}
   ```

8. **\{** и **\}** — используются для создания фигурных скобок. Чтобы вывести `{` и `}`, нужно написать `\{` и `\}` соответственно.
   
   ```latex
   \documentclass{article}
   \begin{document}
   Curly braces look like this: \{ and \}.
   \end{document}
   ```

9. **\\** — используется для новой строки или разрыва строки. Чтобы вывести `\` в тексте, нужно написать `\textbackslash`.
   
   ```latex
   \documentclass{article}
   \usepackage{amsmath}
   \begin{document}
   A backslash looks like this: \textbackslash.
   \end{document}
   ```

10. **<** и **>** — угловые скобки могут использоваться в некоторых контекстах. Чтобы вывести `<` и `>` в тексте, нужно написать `\<` и `\>` соответственно.
    
    ```latex
    \documentclass{article}
    \begin{document}
    Less than and greater than symbols are: \< and \>.
    \end{document}
    ```

11. **|** — вертикальная черта может иметь разное значение в зависимости от контекста. Чтобы вывести `|` в тексте, нужно написать `\|`.
    
    ```latex
    \documentclass{article}
    \begin{document}
    A vertical bar looks like this: \|.
    \end{document}
    ```

12. **"** — кавычки. В LaTeX двойная кавычка экранируется как `''`. Для вывода одиночной кавычки можно использовать `'`.
    
    ```latex
    \documentclass{article}
    \begin{document}
    Quotes can be written as ``double quotes'' or 'single quote'.
    \end{document}
    ```

Эти правила помогут вам правильно экранировать специальные символы в LaTeX-документах, чтобы избежать ошибок при компиляции и получить нужный результат.
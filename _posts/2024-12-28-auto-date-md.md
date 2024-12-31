---
layout: default
title: Как при сохранении файла .md автоматически вставлять текущую дату
permalink: /auto-date-md/
---

Для автоматической вставки текущей даты и создания названия файла формата `YYYY-MM-DD-descriptive-name.md` можно использовать различные инструменты и подходы в зависимости от вашей операционной системы и предпочтений. Вот несколько вариантов:

### 1. Использование скрипта Bash (для Linux/macOS)

Создайте скрипт, который будет генерировать имя файла на основе текущей даты и добавлять к нему произвольный текст.

```bash
#!/bin/bash

# Получаем текущую дату в формате YYYY-MM-DD
date_part=$(date +"%Y-%m-%d")

# Запрашиваем у пользователя описание для файла
read -p "Введите описание для файла: " description

# Формируем полное имя файла
filename="${date_part}-${description}.md"

# Создаем файл с указанным именем
touch "$filename"
echo "# $description" > "$filename"
```

Сохраните этот скрипт под названием, например, `create_md.sh`, сделайте его исполняемым (`chmod +x create_md.sh`) и запускайте каждый раз, когда нужно создать новый `.md` файл.

### 2. Использование PowerShell (для Windows)

На Windows можно воспользоваться PowerShell для выполнения аналогичной задачи.

```powershell
# Получаем текущую дату в формате YYYY-MM-DD
$datePart = Get-Date -Format "yyyy-MM-dd"

# Запрашиваем у пользователя описание для файла
$description = Read-Host "Введите описание для файла"

# Формируем полное имя файла
$filename = "${datePart}-${description}.md"

# Создаем файл с указанным именем
New-Item -Path $filename -ItemType File | Out-Null
Add-Content -Path $filename -Value "# $description"
```

Этот скрипт также можно сохранить в виде `.ps1` файла и запускать его через PowerShell.

### 3. Использование редактора кода с поддержкой макросов/скриптов

Многие редакторы кода поддерживают создание шаблонов файлов или выполнение пользовательских скриптов. Например, в Visual Studio Code можно настроить автоматическое добавление текущей даты в заголовок нового файла с помощью расширения вроде `File Templates`.

#### Шаги настройки

1. Установить расширение **File Templates**.
2. Перейти в настройки расширения и добавить шаблон для Markdown-файлов:

   ```json
   {
     "templates": [
       {
         "name": "Markdown with Date",
         "extension": "md",
         "outputExtension": "md",
         "template": "# ${currentDate:yyyy-MM-dd} - ${input:name}\n\n",
         "description": "Creates a new markdown file with current date in the title."
       }
     ]
   }
   ```

Теперь при создании нового файла с расширением `.md` редактор предложит ввести описание, которое вместе с текущей датой будет добавлено в начало файла.

### 4. Использование GitHub/GitLab CI/CD

Если вы используете системы контроля версий, такие как GitHub или GitLab, то можно настроить автоматизацию создания таких файлов через CI/CD пайплайны. Например, в GitLab CI можно создать задачу, которая будет создавать файлы с нужной структурой имени.

Пример задания для `.gitlab-ci.yml`:

```yaml
create_markdown_file:
  stage: build
  script:
    - date_part=$(date +"%Y-%m-%d")
    - echo "Enter descriptive name for the file:"
    - read description
    - filename="$date_part-$description.md"
    - touch $filename
    - echo "# $description" >> $filename
  artifacts:
    paths:
      - $filename
```

Это задание создаст файл с нужным именем и содержимым после запуска пайплайна.

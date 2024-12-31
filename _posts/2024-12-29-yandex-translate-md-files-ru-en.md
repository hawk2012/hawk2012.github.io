---
layout: default
title: Автоматический перевод на английский всех файлов .md проекта в Windows через переводчик Яндекс
permalink: /yandex-translate-md-files-ru-en/
---

Для выполнения задачи автоматического перевода всех `.md` файлов проекта на английский язык через API Яндекс.Переводчика потребуется написать скрипт на Python. В этом скрипте мы будем использовать библиотеку `requests`, чтобы отправлять HTTP-запросы к API, а также модуль `os` для работы с файлами и директориями.

### Шаги

1. Получаем список всех `.md` файлов в проекте.
2. Для каждого файла отправляем запрос к API Яндекс.Переводчика с содержимым файла.
3. Сохраняем переведенный текст обратно в файл.

### Пример кода

```python
import os
import requests

# Ваш API ключ
api_key = 'abcdef'

# Директория проекта
project_directory = r'C:\path\to\your\project'  # Укажите путь к вашему проекту

def translate_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        text = file.read()
    
    url = 'https://translate.api.cloud.yandex.net/translate/v2/translate'
    headers = {
        'Authorization': f'Api-Key {api_key}'
    }
    params = {
        'lang': 'ru-en',
        'format': 'plain',
        'options': '1'
    }
    data = {
        'texts': [text]
    }

    response = requests.post(url, headers=headers, params=params, json=data)
    if response.status_code == 200:
        translation = response.json()['translations'][0]['text']
        
        # Запись переведенного текста обратно в файл
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(translation)
            
        print(f'Файл {file_path} успешно переведен.')
    else:
        print(f'Ошибка при переводе файла {file_path}: {response.text}')

if __name__ == "__main__":
    for root, dirs, files in os.walk(project_directory):
        for file in files:
            if file.endswith('.md'):
                file_path = os.path.join(root, file)
                translate_file(file_path)
```

### Пояснение

1. **API ключ**: В коде используется ваш API ключ, который передается в заголовках запросов.

2. **Проектная директория**: Вам нужно указать путь к вашей проектной директории, где находятся файлы `.md`.

3. **Функция `translate_file`**

   - Открывает указанный файл, читает содержимое.
   - Отправляет POST-запрос к API Яндекс.Переводчика с параметрами перевода (`ru-en` — русский на английский).
   - Если ответ успешен, записывает переведенное содержание обратно в тот же файл.

4. **Основной блок программы**

   - Использует функцию `os.walk()` для обхода всех поддиректорий в указанной папке.
   - Находит все файлы с расширением `.md` и вызывает функцию перевода для каждого из них.

### Важные моменты

- Убедитесь, что у вас есть достаточный лимит на использование API Яндекс.Переводчика.
- Проверьте корректность пути к проекту и формат передаваемого ключа.
  
Этот скрипт автоматически переведет все ваши `.md` файлы на английский язык и сохранит их в исходных местах.

---
layout: default
title: Пусковой модуль для сайта на Jekyll на Node.js
permalink: /node-jekyll-start/
---

Для создания пускового модуля на Node.js для сайта на Jekyll, вам потребуется создать простой сервер, который будет запускать сборку Jekyll и затем предоставлять статические файлы, созданные этим генератором сайтов. Вот пример того, как вы можете реализовать такой модуль:

### Шаг 1: Установка необходимых пакетов

Вам понадобятся следующие пакеты:
- `jekyll` – для сборки вашего сайта.
- `express` – для создания простого веб-сервера.
- `shelljs` – для выполнения команд оболочки.

Установим их через npm:

```bash
npm install jekyll express shelljs
```

### Шаг 2: Создание скрипта запуска

Создайте файл `server.js`, где будет находиться ваш код сервера:

```javascript
const express = require('express');
const app = express();
const path = require('path');
const shell = require('shelljs');

// Функция для сборки сайта с помощью Jekyll
async function buildJekyll() {
  try {
    // Запускаем команду сборки Jekyll
    const result = await shell.exec('bundle exec jekyll build', { silent: true });
    
    if (result.code !== 0) {
      console.error('Ошибка при сборке Jekyll:', result.stderr);
      process.exit(1); // Завершаем процесс с ошибкой
    }
  
    console.log('Сборка Jekyll завершена успешно.');
  } catch (error) {
    console.error('Произошла ошибка при сборке:', error);
    process.exit(1); // Завершаем процесс с ошибкой
  }
}

// Ожидаем завершения сборки перед стартом сервера
buildJekyll().then(() => {
  // Указываем путь к папке _site, куда Jekyll сохраняет собранные файлы
  app.use(express.static(path.join(__dirname, '_site')));

  // Стартуем сервер на порту 3000
  const port = 3000;
  app.listen(port, () => {
    console.log(`Сервер запущен на http://localhost:${port}`);
  });
});
```

### Шаг 3: Настройка package.json

Добавьте скрипт запуска в файл `package.json`. Ваш `scripts` блок может выглядеть так:

```json
{
  "name": "your-project-name",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "dependencies": {
    "express": "^4.17.1",
    "jekyll": "^4.2.0",
    "shelljs": "^0.8.4"
  },
  "devDependencies": {},
  "scripts": {
    "start": "node server.js"
  },
  "author": "",
  "license": "ISC"
}
```

### Шаг 4: Запуск сервера

Теперь вы можете запустить сервер командой:

```bash
npm start
```

Этот скрипт выполнит сборку вашего сайта с использованием Jekyll, а затем запустит Express-сервер, который будет обслуживать статический контент из папки `_site`.

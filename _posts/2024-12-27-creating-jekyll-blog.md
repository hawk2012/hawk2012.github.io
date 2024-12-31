---
layout: default
title: Как создать блог на Jekyll
permalink: /creating-jekyll-blog/
---

Для создания блога на Jekyll с постраничной навигацией вам потребуется несколько файлов:

### 1. **_config.yml**

Это основной файл конфигурации вашего сайта. В нем вы можете настроить параметры для вашей страницы блога, включая количество постов на одной странице и другие настройки.

```yaml
# Конфигурация Jekyll
title: Мой блог
description: Это мой замечательный блог!
permalink: /blog/:year/:month/:day/:title/
paginate: 10 # Количество постов на одной странице
paginate_path: "/page:num/"
```

### 2. **index.html** или **blog.html**

Этот файл будет содержать список всех ваших постов. Если у вас есть отдельная страница для блога, создайте её под названием `blog.html` или `index.html`, если хотите выводить посты прямо на главной странице.

```html
---
layout: default
title: Блог
---

<div class="posts">
  {% for post in paginator.posts %}
    <div class="post">
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      <p>{{ post.date | date_to_string }}</p>
      {{ post.excerpt }}
    </div>
  {% endfor %}
</div>

<!-- Пагинатор -->
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path }}">Предыдущая страница</a>
  {% endif %}
  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path }}">Следующая страница</a>
  {% endif %}
</div>
```

### 3. **_layouts/default.html**

Файл макета, который будет использоваться для отображения страниц вашего сайта.

```html
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{% if page.title %}{{ page.title }} - {% endif %}{{ site.title }}</title>
  <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
  <header>
    <h1><a href="/">Мой блог</a></h1>
  </header>

  <main>
    {{ content }}
  </main>

  <footer>
    &copy; 2023 Мой блог
  </footer>
</body>
</html>
```

### 4. **Структура папок и файлы постов**

Создайте папку `_posts` и сохраняйте ваши посты в формате `YYYY-MM-DD-title.md`. Например:

```
_posts/2023-09-01-welcome-to-my-blog.md
```

Пример содержимого поста:

```markdown
---
layout: post
title: Добро пожаловать в мой блог!
date: 2023-09-01
categories: приветствие
---

Привет! Это мой первый пост в блоге. Я очень рад поделиться своими мыслями и идеями с вами!
```

Теперь ваш блог будет автоматически генерироваться с постраничной навигацией, а каждый пост будет доступен по своему URL-адресу. Jekyll сам позаботится о том, чтобы все было правильно связано и организовано.
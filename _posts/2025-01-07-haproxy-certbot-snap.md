---
layout: default
title: Установка HAProxy и certbot (snap edition) на Linux
permalink: /haproxy-certbot-snap/
---

HAProxy (High Availability Proxy) — это программное обеспечение для балансировки нагрузки и проксирования TCP/HTTP-соединений. Оно широко используется для обеспечения высокой доступности серверных приложений, распределения трафика между серверами и повышения производительности веб-сервисов. В этой статье рассмотрим процесс установки HAProxy на Linux.

#### Установка HAProxy

Перед установкой любого нового программного обеспечения рекомендуется обновить систему до последних версий пакетов:

```bash
sudo apt update && sudo apt upgrade -y
```

или для CentOS/RHEL:

```bash
sudo yum update -y
```

Для систем на базе Debian или Ubuntu HAProxy можно установить через стандартные репозитории:

```bash
sudo apt install haproxy
```

На системах CentOS или RHEL сначала нужно добавить репозиторий EPEL (Extra Packages for Enterprise Linux), так как стандартный репозиторий может содержать устаревшую версию HAProxy:

```bash
sudo yum install epel-release
sudo yum install haproxy
```

После успешной установки проверьте установленную версию HAProxy:

```bash
haproxy -v
```

И убедитесь, что служба запущена и работает корректно:

```bash
systemctl status haproxy
```

Если служба остановлена, её можно запустить командой:

```bash
sudo systemctl start haproxy
```

Чтобы HAProxy автоматически запускался при загрузке системы, выполните команду:

```bash
sudo systemctl enable haproxy
```

Основной файл конфигурации HAProxy находится в директории `/etc/haproxy`. Файл называется `haproxy.cfg`.

Пример базовой настройки для балансировки HTTP-трафика между двумя серверами:

```bash
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log global
    mode http
    option httplog
    option dontlognull
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
    bind *:80
    default_backend servers

backend servers
    balance roundrobin
    server server1 192.168.1.10:80 check
    server server2 192.168.1.11:80 check
```

В этом примере:

- **Frontend** (`http-in`) прослушивает порт 80 и перенаправляет трафик на бэкенды.
- **Backend** (`servers`) содержит два сервера, между которыми распределяется нагрузка с использованием алгоритма `roundrobin` (циклическая передача запросов).

После внесения изменений в конфигурацию необходимо перезапустить службу HAProxy:

```bash
sudo systemctl restart haproxy
```

HAProxy предоставляет встроенный интерфейс мониторинга, который позволяет отслеживать состояние серверов и нагрузку на них. Чтобы включить мониторинг, добавьте следующие строки в секцию `listen` вашего файла конфигурации:

```bash
listen stats
    bind :8080
    stats enable
    stats uri /
    stats auth username:password
```

Замените `username` и `password` на свои данные для аутентификации. После этого вы сможете открыть браузер и перейти по адресу `http://<IP-адрес>:8080`, чтобы увидеть статистику работы HAProxy.

#### Установка Certbot через snap

Certbot — это автоматический клиент для получения и обновления сертификатов Let’s Encrypt. Один из способов установки Certbot на Linux — использование менеджера пакетов Snap. Вот пошаговая инструкция по установке Certbot через Snap.

Snapd — это менеджер пакетов, который управляет приложениями в формате Snap. Если он уже установлен, пропустите этот шаг.

Для Ubuntu:

```bash
sudo apt update
sudo apt install snapd
```

Для CentOS/RHEL:

```bash
sudo yum install epel-release
sudo yum install snapd
```

Запустите и включите службу Snapd:

```bash
sudo systemctl enable --now snapd.socket
```

Теперь установим сам Certbot:

```bash
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
```

Чтобы команда `certbot` была доступна в вашей системе, создайте символическую ссылку:

```bash
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

Теперь вы можете использовать Certbot для получения сертификата. Например, чтобы получить сертификат для доменного имени `example.com`, выполните следующую команду:

```bash
sudo certbot certonly --webroot -w /var/www/html -d example.com
```

Здесь:

- `certonly`: Указывает, что мы хотим только получить сертификат, без автоматической настройки веб-сервера.
- `--webroot`: Использует метод проверки владения доменом через размещение файла в корневой директории сайта.
- `-w /var/www/html`: Путь к корню вашего веб-сайта.
- `-d example.com`: Доменное имя, для которого вы хотите получить сертификат.

Certbot создает задание cron для автоматического обновления сертификатов. Вы можете проверить его статус следующим образом:

```bash
sudo systemctl status snap.certbot.renew.service
```

Если все настроено правильно, сертификаты будут обновляться автоматически каждые 90 дней.

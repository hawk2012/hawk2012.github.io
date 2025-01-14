---
layout: default
title: Исправляем ошибку на Linux &laquo;31 - Encryption(ssl/tls) handshake failed&raquo;
permalink: /tls-handshake-failed/
---

Симптомы:

В логах приложения на linux: `A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: SSL Provider, error: 31 - Encryption(ssl/tls) handshake failed)`.

В логах Windows server 2012: `An TLS 1.2 connection request was received from a remote client application, but none of the cipher suites supported by the client application are supported by the server. The SSL connection request has failed`.

Ошибка, которую вы видите, связана с тем, что клиентское приложение пытается установить соединение с использованием протокола TLS 1.2, но сервер не поддерживает ни одного из шифров, предложенных клиентом. Это может произойти из-за того, что Windows Server 2012 использует устаревшие алгоритмы шифрования, которые больше не поддерживаются современными клиентами.

Для решения этой проблемы вам нужно настроить поддержку современных шифров на сервере SQL Server, работающем под управлением Windows Server 2012. Вот шаги, которые помогут вам сделать это:

### Шаг 1: Обновление Windows Server 2012 до актуальной версии

Убедитесь, что ваша версия Windows Server 2012 обновлена до последней доступной версии. Для этого выполните следующие команды в PowerShell с правами администратора:

```powershell
Install-Module PSWindowsUpdate
Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot
```

Это установит все доступные обновления для вашей системы.

### Шаг 2: Настройка поддержки TLS 1.2 на уровне операционной системы

Проверьте, включены ли протоколы TLS 1.2 на вашем сервере. Для этого откройте редактор реестра (`regedit`) и перейдите к следующим ключам:

#### Включение TLS 1.2

1. Перейдите к `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client`.
2. Создайте (если отсутствует) параметр типа DWORD с именем `DisabledByDefault` и значением `0`.
3. Создайте (если отсутствует) параметр типа DWORD с именем `Enabled` и значением `1`.

4. Перейдите к `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server`.
5. Создайте (если отсутствует) параметр типа DWORD с именем `DisabledByDefault` и значением `0`.
6. Создайте (если отсутствует) параметр типа DWORD с именем `Enabled` и значением `1`.

#### Отключение старых протоколов (SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1)

Чтобы повысить безопасность, рекомендуется отключить старые протоколы:

1. Перейдите к `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client`.
2. Создайте (если отсутствует) параметр типа DWORD с именем `DisabledByDefault` и значением `1`.
3. Создайте (если отсутствует) параметр типа DWORD с именем `Enabled` и значением `0`.

4. Перейдите к `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server`.
5. Создайте (если отсутствует) параметр типа DWORD с именем `DisabledByDefault` и значением `1`.
6. Создайте (если отсутствует) параметр типа DWORD с именем `Enabled` и значением `0`.

7. Повторите аналогичные шаги для `SSL 3.0`, `TLS 1.0` и `TLS 1.1`.

### Шаг 3: Установка актуальных патчей безопасности для SQL Server 2014

Обязательно убедитесь, что у вас установлены последние обновления безопасности для SQL Server 2014 SP3. Проверьте наличие новых сервисных пакетов и кумулятивных обновлений через Центр обновлений Microsoft или вручную загрузив их с сайта Microsoft.

### Шаг 4: Настройка поддержки TLS 1.2 в SQL Server

После выполнения всех предыдущих шагов перезапустите сервер, чтобы изменения вступили в силу. Затем проверьте, что SQL Server теперь поддерживает TLS 1.2:

1. Откройте **SQL Server Configuration Manager**.
2. Выберите **SQL Server Network Configuration** > **Protocols for MSSQLSERVER**.
3. Убедитесь, что протокол TCP/IP включен.
4. Дважды щелкните на **TCP/IP**, затем выберите вкладку **IP Addresses**.
5. Прокрутите вниз до раздела **IPAll** и убедитесь, что значение параметра **Enabled** установлено в `Yes`.
6. Сохраните изменения и перезапустите службу SQL Server.

### Шаг 5: Проверка соединения

Теперь попробуйте снова подключиться к вашему SQL Server 2014 с клиента Linux. Если всё было настроено правильно, ошибка должна исчезнуть, и соединение будет успешно установлено.

### Дополнительная информация

Если после выполнения этих шагов проблема сохраняется, возможно, стоит проверить настройки брандмауэра и убедиться, что он разрешает трафик по порту, который используется вашим SQL Server (обычно это порт 1433).

Также обратите внимание, что некоторые клиенты могут требовать явного указания использования TLS 1.2 при установлении соединения. Например, в приложении на Python с использованием библиотеки `pyodbc` это можно сделать так:

```python
import pyodbc
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                      'SERVER=your_server_name;'
                      'DATABASE=your_database;'
                      'UID=your_username;'
                      'PWD=your_password;',
                      encrypt='yes',
                      ssl_protocol='tlsv1_2')
```

Надеюсь, эти шаги помогут вам решить проблему!

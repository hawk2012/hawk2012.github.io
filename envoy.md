---
layout: default
title: Установка Envoy в условиях блокировки Docker
description: "Данная инструкция подходит абсолютно для всех операционных систем семейства Linux, поддерживающих Docker."
permalink: /envoy-lock-install/
---

<p>Данная инструкция подходит абсолютно для всех операционных систем семейства Linux, поддерживающих Docker.</p>
<p>Нам будут нужны следующие компоненты:</p>
<p>- Среда Portainer CE для развертывания.</p>
<p>- Образ Envoy в формате TAR.</p>
<p>- Немного времени.</p>

<h4>Установка Portainer</h4>
<p>Установка для всех систем кроме Ред ОС производится из обычного репозитория.</p>
<p>Он располагается <a href="https://docs.portainer.io/start/install-ce/server/docker/linux" target="_blank">здесь</a>.</p>

<h5>Особенности для Ред ОС</h5>
<p>Portainer в Ред ОС уже содержится в репозиториях и не надо устанавливать его &laquo;со стороны&raquo;. В этом есть и свои плюсы. Я буду использовать yum вместо dnf, так мне привычнее, тем более что yum в Ред ОС 8 - симлинк на dnf.</p>
<p>Удостоверяемся что он есть в репозитории:</p>
<p><kbd>sudo yum search portainer</kbd></p>
<p><img src="~/img/p00.png" /></p>
<p>Затем ставим пакет:</p>
<p><kbd>sudo yum install portainer-ce -y</kbd></p>
<p>Включаем Portainer на автозапуск.</p>
<p><kbd>sudo systemctl enable portainer --now</kbd></p>
<p>Проверяем работу.</p>
<p><kbd>sudo systemctl status portainer</kbd></p>
<p><img src="~/img/p01.png" /></p>
<p>Нажимаем букву <tt>q</tt>, чтобы выйти из журнала.</p>

<h4>Для всех систем</h4>
<p><b>Ахтунг</b>. Если у вас фаерволл, то порты надо пробросить. Это 8000 и 9443.</p>
<p>На iptables пробрасывается так:</p>
<p>Добавляем правило в таблицу NAT для порта 8000</p>
<p><kbd>iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8000 -j DNAT --to :8000</kbd></p>
<p>Добавляем правило в таблицу NAT для порта 9443</p>
<p><kbd>iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 9443 -j DNAT --to :9443</kbd></p>
<p>Добавляем правило в таблицу фильтрации для порта 8000</p>
<p><kbd>iptables -I INPUT -m state --state NEW -p tcp --dport 8000 -j ACCEPT</kbd></p>
<p>Добавляем правило в таблицу фильтрации для порта 9443</p>
<p><kbd>iptables -I INPUT -m state --state NEW -p tcp --dport 9443 -j ACCEPT</kbd></p>
<p>А на firewalld пробрасывается так:</p>
<p><kbd>firewall-cmd --permanent --add-port=9443/tcp</kbd></p>
<p><kbd>firewall-cmd --permanent --add-port=8000/tcp</kbd></p>

<h4>Настройка Portainer</h4>
<p>В графическом режиме заходим в ваш любимый браузер и открываем адрес <tt>https://localhost:9443</tt>.</p>
<p>Если показало подобное:</p>
<p><img src="~/img/p02.png" /></p>
<p>Выполняем.</p>
<p><kbd>sudo systemctl restart {portainer,docker}</kbd></p>
<p>Это перезагрузит оба сервиса.</p>
<p>Теперь нажимаем клавишу <tt>F5</tt> и вводим данные админа. Запоминаем их! Пароль нужен длиной 12 символов.</p>
<p>Нажимаем кнопку "Create user", затем выбираем локальный сервер нажав на "Default" а затем "local".</p>

<h4>Настройка и запуск контейнера</h4>
<p>Скачиваем в домашнюю папку образ Envoy с моего зеркала.</p>
<p><kbd>wget -O envoy.tar https://wget.gubin.systems/docker/envoy.tar</kbd></p>
<p>Идем в пункт меню "Images" (образы) и нажимаем "Import".</p>
<p><img src="~/img/p03.png" /></p>
<p>Нажимаем кнопку "Select file". </p>
<p>Выбираем скачанный TAR.</p>
<p><img src="~/img/p04.png" /></p>
<p>Нажимаем кнопку "Upload" внизу страницы.</p>
<p>Теперь целиком копируем то, что написано в "Image tags". Это ID образа, он сейчас нам будет нужен.</p>
<p><img src="~/img/p06.png" /></p>
<p>Идем в пункт меню "Containers" (контейнеры).</p>
<p>Нажимаем "Add Container". Убираем "Always pull the image" (всегда загружать образ).</p>
<p>Переключаемся на Advanced Mode (маленькая ссылка). В "image" вставляем то, что скопировали (ID образа).</p>
<p><img src="~/img/p07.png" /></p>
<p><img src="~/img/p08.png" /></p>
<p>В самом низу страницы выбираем переключатель "Interactive & TTY". Это позволит читать консоль и логи.</p>
<p><img src="~/img/p09.png" /></p>
<p>И наконец, нажимаем "Deploy the container" (развернуть контейнер).</p>
<p><img src="~/img/p010.png" /></p>
<p>Проверяем работает ли все. Нажимаем на имя контейнера в списке.</p>
<p><img src="~/img/p011.png" /></p>
<p>И открываем "Logs" (Журналы).</p>
<p><img src="~/img/p012.png" /></p>
<p>Все, видим что наш контейнер успешно работает.</p>
<p><img src="~/img/p013.png" /></p>
<p>Порты есть в логе, их также можно поменять через Portainer, для этого зайдите: "Duplicate/Edit -> + map additional port" и впишите значения, затем опять нажмите "Deploy the container" и затем "Replace" (заменить).</p>
---
layout: default
title: Удаление правила из iptables
permalink: /iptables-rm-rule/
---

Чтобы удалить правило из iptables, нужно сначала узнать номер строки этого правила. Для этого выполни команду:

```bash
iptables -L --line-numbers
```

Эта команда выведет список всех правил вместе с их номерами строк.

Затем, чтобы удалить конкретное правило, используй следующую команду:

```bash
iptables -D CHAIN_NUMBER RULE_NUMBER
```

Где `CHAIN_NUMBER` — это номер цепочки (например, INPUT, OUTPUT, FORWARD), а `RULE_NUMBER` — номер строки правила, которое ты хочешь удалить.

Пример удаления правила из цепочки INPUT:

```bash
iptables -D INPUT 4
```

Это удалит четвертое правило из цепочки INPUT.
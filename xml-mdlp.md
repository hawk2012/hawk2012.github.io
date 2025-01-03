---
layout: default
title: Образцы схем МДЛП
description: "XML схемы передачи документов в систему МДЛП Честного знака."
permalink: /xml-mdlp/
---

<p>Чтобы обеспечить корректную передачу данных о движении лекарственных препаратов в системе МДЛП, необходимо соблюдать определённый формат XML-документов. В данной статье мы рассмотрим основные требования к XML схемам передачи документов в систему МДЛП &laquo;Честный знак&raquo;.</p>
<p>Основные элементы XML схемы для передачи документов в систему МДЛП «Честный знак» включают следующие разделы:</p>
<p>1. Заголовок документа. Этот раздел содержит информацию о версии формата данных, идентификаторе отправителя и получателя сообщения, дате и времени отправки сообщения.</p>
<p>2. Информационная часть. Здесь содержится информация о самом документе: его типе (например, уведомление о приёмке товара), идентификаторе документа, номере версии документа и других параметрах.</p>
<p>3. Тело документа. Это основной раздел, содержащий данные о товарах, которые передаются в систему МДЛП &laquo;Честный знак&raquo;. В этом разделе указываются характеристики каждого товара: наименование, код товара, количество единиц товара и другие параметры.</p>
<p>4. Подпись документа. Этот раздел содержит электронную подпись документа, которая используется для подтверждения целостности и подлинности передаваемых данных.</p>
<p>При создании XML схемы передачи документов в систему МДЛП &laquo;Честный знак&raquo; необходимо учитывать следующие требования:</p>
<p>— Документ должен соответствовать стандарту XML 1.0.</p>
<p>— Все элементы должны иметь уникальные имена.</p>
<p>— Элементы должны быть вложенными друг в друга в соответствии с логикой структуры данных.</p>
<p>— Каждый элемент должен иметь одно или несколько значений атрибутов, которые описывают его свойства.</p>
<p>— Для каждого элемента должна быть предусмотрена возможность добавления комментариев и заметок.</p>
<p>— Документ должен быть подписан электронной подписью, соответствующей требованиям законодательства РФ.</p>
<p>Приложенные схемы предназначены для программистов и интеграторов.</p>
<p><a href="https://честныйзнак.рф/upload/Primery-XML-s-result.7z" target="_blank" rel="nofollow">Примеры XML с result_v1.38_20.10.2023</a> | <a href="https://честныйзнак.рф/upload/Opisanie_kodov_oshibok_pri_obrabotke_xml.pdf" target="_blank" rel="nofollow">Описание кодов ошибок при обработке XML документов</a></p>
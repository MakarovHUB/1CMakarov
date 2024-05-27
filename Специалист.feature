﻿#language: ru

@tree

Функционал: Проведение документа специалистом

Как Специалист я хочу
заполнить данные и провести документ
чтобы проверить работоспособность формы  

Контекст:
	Дано я подключаю TestClient "Test" логин "КозинФД" пароль ""

Сценарий: Я провожу документ под специалистом


*Проведение первого документа
И В командном интерфейсе я выбираю "Обслуживание клиентов" "Обслуживание клиента"
Тогда открылось окно "Обслуживание клиента"
И в таблице 'Список' я перехожу к строке:
| "Дата проведения работ" | "Клиент"    | "Специалист"              |
| "20.05.2024"            | "ИП Павлов" | "Кузьмин Матвей Маркович" |
И в таблице 'Список' я выбираю текущую строку
Тогда открылось окно "Обслуживание клиента * от *"
И я разворачиваю группу с именем 'ГруппаОписаниеПроблемы'
И в таблице 'ТЧ_ВыполненныеРаботы' я нажимаю на кнопку с именем 'ТЧ_ВыполненныеРаботыДобавить'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыОписаниеРаботы' я ввожу текст "Переустановил Windows"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст "6"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст "6"
И я разворачиваю группу с именем 'ГруппаКомментарий'
И в таблице 'ТЧ_ВыполненныеРаботы' я завершаю редактирование строки
И в поле с именем 'Комментарий' я ввожу текст "Выполнено"
И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
И я жду закрытия окна "Обслуживание клиента * от * *" в течение 20 секунд


*Проведение второго документа
И В командном интерфейсе я выбираю "Обслуживание клиентов" "Обслуживание клиента"
Тогда открылось окно "Обслуживание клиента"
И в таблице 'Список' я перехожу к строке:
| "Дата проведения работ" | "Клиент"       | "Специалист"                  |
| "20.05.2024"            | "ИП Богданова" | "Пономарев Никита Дмитриевич" |
И в таблице 'Список' я выбираю текущую строку
Тогда открылось окно "Обслуживание клиента * от *"
И я разворачиваю группу с именем 'ГруппаОписаниеПроблемы'
И в таблице 'ТЧ_ВыполненныеРаботы' я нажимаю на кнопку с именем 'ТЧ_ВыполненныеРаботыДобавить'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыОписаниеРаботы' я ввожу текст "Починил принтер"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст "6"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст "6"
И я разворачиваю группу с именем 'ГруппаКомментарий'
И в таблице 'ТЧ_ВыполненныеРаботы' я завершаю редактирование строки
И в поле с именем 'Комментарий' я ввожу текст "Выполнено"
И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
И я жду закрытия окна "Обслуживание клиента * от * *" в течение 20 секунд

*Проведение третьего документа
И В командном интерфейсе я выбираю "Обслуживание клиентов" "Обслуживание клиента"
Тогда открылось окно "Обслуживание клиента"
И в таблице 'Список' я перехожу к строке:
| "Дата проведения работ" | "Клиент"       | "Специалист"               |
| "20.05.2024"            | "ИП Смирнов" | "Степанов Андрей Тимофеевич" |
И в таблице 'Список' я выбираю текущую строку
Тогда открылось окно "Обслуживание клиента * от *"
И я разворачиваю группу с именем 'ГруппаОписаниеПроблемы'
И в таблице 'ТЧ_ВыполненныеРаботы' я нажимаю на кнопку с именем 'ТЧ_ВыполненныеРаботыДобавить'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыОписаниеРаботы' я ввожу текст "Починил принтер"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст "9"
И в таблице 'ТЧ_ВыполненныеРаботы' я активизирую поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов'
И в таблице 'ТЧ_ВыполненныеРаботы' в поле с именем 'ТЧ_ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст "9"
И я разворачиваю группу с именем 'ГруппаКомментарий'
И в таблице 'ТЧ_ВыполненныеРаботы' я завершаю редактирование строки
И в поле с именем 'Комментарий' я ввожу текст "Выполнено"
И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
И я жду закрытия окна "Обслуживание клиента * от * *" в течение 20 секунд


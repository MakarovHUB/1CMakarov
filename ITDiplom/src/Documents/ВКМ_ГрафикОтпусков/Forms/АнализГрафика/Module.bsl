#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Адрес = Параметры.Адрес;
	ОтпускаСотрудников.Загрузить(ПолучитьИзВременногоХранилища(Адрес));

	ДиаграммаГанта.Очистить();
	ДиаграммаГанта.Обновление = Ложь;

	Для Каждого Строка Из ОтпускаСотрудников Цикл

		ТочкаДГ = ДиаграммаГанта.УстановитьТочку(Строка.Сотрудник);
		СерияДГ = ДиаграммаГанта.УстановитьСерию("Отпуск");

		Значение = ДиаграммаГанта.ПолучитьЗначение(ТочкаДГ, СерияДГ);

		Интервал = Значение.Добавить();
		Интервал.Начало = Строка.ДатаНачала;
		Интервал.Конец = Строка.ДатаОкончания;

	КонецЦикла;

	ДиаграммаГанта.Обновление = Истина;

КонецПроцедуры

#КонецОбласти


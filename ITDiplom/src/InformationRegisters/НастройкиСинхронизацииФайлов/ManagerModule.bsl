///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

 


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Возвращаемое значение:
//   ТаблицаЗначений:
//   * ВладелецФайла - ЛюбаяСсылка
//   * ИдентификаторВладельца - СправочникСсылка.ИдентификаторыОбъектовМетаданных
//   * ЭтоНастройкаДляЭлементаСправочника - Булево
//   * ТипВладельцаФайла - СправочникСсылка.ИдентификаторыОбъектовМетаданных
//   * ПравилоОтбора - ХранилищеЗначения
//   * ЭтоФайл - Булево
//   * Синхронизировать - Булево
//   * УчетнаяЗапись - СправочникСсылка.УчетныеЗаписиСинхронизацииФайлов
//   * Наименование - Строка
//
Функция ТекущиеНастройкиСинхронизации() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбновитьНастройкиСинхронизации();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	НастройкиСинхронизацииФайлов.ВладелецФайла,
		|	ИдентификаторыОбъектовМетаданных.Ссылка КАК ИдентификаторВладельца,
		|	ВЫБОР
		|		КОГДА ТИПЗНАЧЕНИЯ(ИдентификаторыОбъектовМетаданных.Ссылка) <> ТИПЗНАЧЕНИЯ(НастройкиСинхронизацииФайлов.ВладелецФайла)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК ЭтоНастройкаДляЭлементаСправочника,
		|	НастройкиСинхронизацииФайлов.ТипВладельцаФайла,
		|	НастройкиСинхронизацииФайлов.ПравилоОтбора,
		|	НастройкиСинхронизацииФайлов.ЭтоФайл,
		|	НастройкиСинхронизацииФайлов.Синхронизировать,
		|	НастройкиСинхронизацииФайлов.УчетнаяЗапись,
		|	НастройкиСинхронизацииФайлов.Наименование
		|ИЗ
		|	РегистрСведений.НастройкиСинхронизацииФайлов КАК НастройкиСинхронизацииФайлов
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ИдентификаторыОбъектовМетаданных КАК ИдентификаторыОбъектовМетаданных
		|		ПО (ТИПЗНАЧЕНИЯ(НастройкиСинхронизацииФайлов.ВладелецФайла) = ТИПЗНАЧЕНИЯ(ИдентификаторыОбъектовМетаданных.ЗначениеПустойСсылки))
		|ГДЕ
		|	НастройкиСинхронизацииФайлов.УчетнаяЗапись <> ЗНАЧЕНИЕ(Справочник.УчетныеЗаписиСинхронизацииФайлов.ПустаяСсылка)";
		
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

Процедура ОбновитьНастройкиСинхронизации()
	
	ТаблицаВладельцевФайлов = Новый ТаблицаЗначений;
	ТаблицаВладельцевФайлов.Колонки.Добавить("ВладелецФайла",     Новый ОписаниеТипов("СправочникСсылка.ИдентификаторыОбъектовМетаданных"));
	ТаблицаВладельцевФайлов.Колонки.Добавить("ТипВладельцаФайла", Новый ОписаниеТипов("СправочникСсылка.ИдентификаторыОбъектовМетаданных"));
	ТаблицаВладельцевФайлов.Колонки.Добавить("ЭтоФайл",           Новый ОписаниеТипов("Булево"));
	
	ИсключенияСинхронизацииФайлов = Новый Соответствие;
	Для каждого ИсключениеСинхронизации Из РаботаСФайламиСлужебный.ПриОпределенииОбъектовИсключенияСинхронизацииФайлов() Цикл
		ИсключенияСинхронизацииФайлов[ИсключениеСинхронизации.ПолноеИмя()] = Истина;
	КонецЦикла;	
	
	Для Каждого Справочник Из Метаданные.Справочники Цикл
		Если Справочник.Реквизиты.Найти("ВладелецФайла") = Неопределено Тогда
			Продолжить;
		КонецЕсли;
			
		ТипыВладельцевФайлов = ОбщегоНазначения.ИдентификаторыОбъектовМетаданных(Справочник.Реквизиты.ВладелецФайла.Тип.Типы());
		Для Каждого ТипВладельца Из ТипыВладельцевФайлов Цикл
			
			Если ИсключенияСинхронизацииФайлов[ТипВладельца.Ключ] <> Неопределено Тогда
				Продолжить;
			КонецЕсли;	
				
			ВладелецФайла = ТипВладельца.Значение;
			НоваяСтрока  = ТаблицаВладельцевФайлов.Добавить();
			НоваяСтрока.ВладелецФайла = ВладелецФайла;
			НоваяСтрока.ТипВладельцаФайла= ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Справочник);
			НоваяСтрока.ЭтоФайл = Не СтрЗаканчиваетсяНа(Справочник.Имя, "ПрисоединенныеФайлы");
		КонецЦикла;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаВладельцевФайлов.ВладелецФайла КАК ВладелецФайла,
		|	ТаблицаВладельцевФайлов.ТипВладельцаФайла КАК ТипВладельцаФайла,
		|	ТаблицаВладельцевФайлов.ЭтоФайл КАК ЭтоФайл
		|ПОМЕСТИТЬ ТаблицаВладельцевФайлов
		|ИЗ
		|	&ТаблицаВладельцевФайлов КАК ТаблицаВладельцевФайлов
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ВладелецФайла,
		|	ЭтоФайл
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	НастройкиСинхронизацииФайлов.ВладелецФайла,
		|	НастройкиСинхронизацииФайлов.ТипВладельцаФайла КАК ТипВладельцаФайла,
		|	НастройкиСинхронизацииФайлов.ЭтоФайл КАК ЭтоФайл,
		|	ИдентификаторыОбъектовМетаданных.Ссылка КАК ИдентификаторОбъекта,
		|	НастройкиСинхронизацииФайлов.Наименование
		|ПОМЕСТИТЬ ПодчиненныеНастройки
		|ИЗ
		|	РегистрСведений.НастройкиСинхронизацииФайлов КАК НастройкиСинхронизацииФайлов
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ИдентификаторыОбъектовМетаданных КАК ИдентификаторыОбъектовМетаданных
		|		ПО (ТИПЗНАЧЕНИЯ(НастройкиСинхронизацииФайлов.ВладелецФайла) = ТИПЗНАЧЕНИЯ(ИдентификаторыОбъектовМетаданных.ЗначениеПустойСсылки))
		|ГДЕ
		|	ТИПЗНАЧЕНИЯ(НастройкиСинхронизацииФайлов.ВладелецФайла) <> ТИП(Справочник.ИдентификаторыОбъектовМетаданных)
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ИдентификаторОбъекта,
		|	ЭтоФайл,
		|	ТипВладельцаФайла
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	НастройкиСинхронизацииФайлов.ВладелецФайла,
		|	НастройкиСинхронизацииФайлов.ТипВладельцаФайла КАК ТипВладельцаФайла,
		|	НастройкиСинхронизацииФайлов.ЭтоФайл,
		|	ЛОЖЬ КАК НоваяНастройка,
		|	НастройкиСинхронизацииФайлов.Наименование
		|ИЗ
		|	РегистрСведений.НастройкиСинхронизацииФайлов КАК НастройкиСинхронизацииФайлов
		|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаВладельцевФайлов КАК ТаблицаВладельцевФайлов
		|		ПО НастройкиСинхронизацииФайлов.ВладелецФайла = ТаблицаВладельцевФайлов.ВладелецФайла
		|			И НастройкиСинхронизацииФайлов.ЭтоФайл = ТаблицаВладельцевФайлов.ЭтоФайл
		|			И НастройкиСинхронизацииФайлов.ТипВладельцаФайла = ТаблицаВладельцевФайлов.ТипВладельцаФайла
		|ГДЕ
		|	ТаблицаВладельцевФайлов.ВладелецФайла ЕСТЬ NULL 
		|	И ТИПЗНАЧЕНИЯ(НастройкиСинхронизацииФайлов.ВладелецФайла) = ТИП(Справочник.ИдентификаторыОбъектовМетаданных)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПодчиненныеНастройки.ВладелецФайла,
		|	ПодчиненныеНастройки.ТипВладельцаФайла,
		|	ПодчиненныеНастройки.ЭтоФайл,
		|	ЛОЖЬ,
		|	ПодчиненныеНастройки.Наименование
		|ИЗ
		|	ПодчиненныеНастройки КАК ПодчиненныеНастройки
		|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаВладельцевФайлов КАК ТаблицаВладельцевФайлов
		|		ПО ПодчиненныеНастройки.ТипВладельцаФайла = ТаблицаВладельцевФайлов.ТипВладельцаФайла
		|			И ПодчиненныеНастройки.ЭтоФайл = ТаблицаВладельцевФайлов.ЭтоФайл
		|			И ПодчиненныеНастройки.ИдентификаторОбъекта = ТаблицаВладельцевФайлов.ВладелецФайла
		|ГДЕ
		|	ТаблицаВладельцевФайлов.ВладелецФайла ЕСТЬ NULL ";
	
	Запрос.Параметры.Вставить("ТаблицаВладельцевФайлов", ТаблицаВладельцевФайлов);
	ОбщаяТаблицаНастроек = Запрос.Выполнить().Выгрузить();
	
	НастройкиДляУдаления = ОбщаяТаблицаНастроек.НайтиСтроки(Новый Структура("НоваяНастройка", Ложь));
	Для Каждого Настройка Из НастройкиДляУдаления Цикл
		МенеджерЗаписи = СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ВладелецФайла = Настройка.ВладелецФайла;
		МенеджерЗаписи.ТипВладельцаФайла = Настройка.ТипВладельцаФайла;
		МенеджерЗаписи.Удалить();
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
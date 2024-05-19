///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

 


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	БезопасныйРежим = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗагрузитьФайлОбработки();
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Не ЗначениеЗаполнено(ФайлОбработкиИмя) Или Не ЗначениеЗаполнено(ФайлОбработкиАдрес) Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Укажите файл внешнего отчета или обработки.'"),, 
			"ФайлОбработкиИмя");
		Отказ = Истина;
	Иначе
		СвойстваФайла = ОбщегоНазначенияКлиентСервер.РазложитьПолноеИмяФайла(ФайлОбработкиИмя);
		Если НРег(СвойстваФайла.Расширение) <> НРег(".epf") И НРег(СвойстваФайла.Расширение) <> НРег(".erf") Тогда
			ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Выбранный файл не является внешним отчетом или обработкой.'"),,
				"ФайлОбработкиИмя");
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(БезопасныйРежим) Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Укажите безопасный режим для подключения внешнего модуля.'"),, 
			"БезопасныйРежим");
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФайлОбработкиИмяНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ЗагрузитьФайлОбработки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПодключитьИОткрыть(Команда)
	
	ОчиститьСообщения();
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;	
	
	СвойстваФайла = ОбщегоНазначенияКлиентСервер.РазложитьПолноеИмяФайла(ФайлОбработкиИмя);
	ЭтоВнешняяОбработка = (НРег(СвойстваФайла.Расширение) = НРег(".epf"));
	
	ИмяВнешнегоОбъекта = ПодключитьНаСервере(ЭтоВнешняяОбработка);
	Если ЭтоВнешняяОбработка Тогда
		ИмяВнешнейФормы = "ВнешняяОбработка." + ИмяВнешнегоОбъекта + ".Форма";
	Иначе
		ИмяВнешнейФормы = "ВнешнийОтчет." + ИмяВнешнегоОбъекта + ".Форма";
	КонецЕсли;
	
	ОткрытьФорму(ИмяВнешнейФормы, , ВладелецФормы);
	Закрыть();
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗагрузитьФайлОбработки()
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьФайлОбработкиЗавершение", ЭтотОбъект);
	ПараметрыЗагрузки = ФайловаяСистемаКлиент.ПараметрыЗагрузкиФайла();
	ПараметрыЗагрузки.ИдентификаторФормы = УникальныйИдентификатор;
	ФайловаяСистемаКлиент.ЗагрузитьФайл(Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьФайлОбработкиЗавершение(ПомещенныйФайл, ДополнительныеПараметры) Экспорт
	
	Если ПомещенныйФайл = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ФайлОбработкиИмя = ПомещенныйФайл.Имя;
	ФайлОбработкиАдрес = ПомещенныйФайл.Хранение;
	
	СвойстваФайла = ОбщегоНазначенияКлиентСервер.РазложитьПолноеИмяФайла(ФайлОбработкиИмя);
	Если НРег(СвойстваФайла.Расширение) <> НРег(".epf") И НРег(СвойстваФайла.Расширение) <> НРег(".erf") Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Выбранный файл не является внешним отчетом или обработкой.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПодключитьНаСервере(ЭтоВнешняяОбработка)
	
	ВыполнитьПроверкуПравДоступа("Администрирование", Метаданные);
	
	Если ЭтоВнешняяОбработка Тогда
		Менеджер = ВнешниеОбработки;
	Иначе
		Менеджер = ВнешниеОтчеты;
	КонецЕсли;
	
	Возврат Менеджер.Подключить(ФайлОбработкиАдрес,, БезопасныйРежим); // АПК:552; АПК:553 Безопасное подключение.
	
КонецФункции

#КонецОбласти

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
	
	Если Параметры.РежимВыбора Тогда
		СтандартныеПодсистемыСервер.УстановитьКлючНазначенияФормы(ЭтотОбъект, "ВыборПодбор");
		РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("Владелец") Тогда
		Свойство = Параметры.Отбор.Владелец;
		Параметры.Отбор.Удалить("Владелец");
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Свойство) Тогда
		Элементы.Свойство.Видимость = Истина;
		НастроитьПорядокЗначенийПоСвойствам(Список);
	КонецЕсли;
	
	Элементы.Список.РежимВыбора = Параметры.РежимВыбора;
	
	УстановитьЗаголовок();
	
	ПриИзмененииСвойства();
	
	СуффиксТекущегоЯзыка = ОбщегоНазначения.СуффиксЯзыкаТекущегоПользователя();
	Если СуффиксТекущегоЯзыка = Неопределено Тогда
		
		СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
		
		СвойстваСписка.ТекстЗапроса = Список.ТекстЗапроса + "
		|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ЗначенияСвойствОбъектовИерархия.Представления КАК ЗначенияПредставления
		| ПО (ЗначенияПредставления.Ссылка = ЗначенияПереопределяемый.Ссылка)
		| И ЗначенияПредставления.КодЯзыка = &КодЯзыка";
		
		СвойстваСписка.ТекстЗапроса = СтрЗаменить(СвойстваСписка.ТекстЗапроса, "ЗначенияПереопределяемый.Наименование КАК Наименование",
			"ВЫРАЗИТЬ(ЕСТЬNULL(ЗначенияПредставления.Наименование, ЗначенияПереопределяемый.Наименование) КАК СТРОКА(150)) КАК Наименование");
		
		ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);
		
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
			Список, "КодЯзыка", ТекущийЯзык().КодЯзыка, Истина);
		
	ИначеЕсли ЗначениеЗаполнено(СуффиксТекущегоЯзыка) Тогда
		
		Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Мультиязычность") Тогда
			МодульМультиязычностьСервер = ОбщегоНазначения.ОбщийМодуль("МультиязычностьСервер");
			МодульМультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
		КонецЕсли;
	КонецЕсли;
	
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ДополнительныеРеквизитыИСведения"
	   И Источник = Свойство Тогда
		
		ПодключитьОбработчикОжидания("ОбработчикОжиданияПриИзмененииСвойства", 0.1, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СвойствоПриИзменении(Элемент)
	
	ПриИзмененииСвойства();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если НЕ Копирование
	   И Элементы.Список.Отображение = ОтображениеТаблицы.Список Тогда
		
		Родитель = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура НастроитьПорядокЗначенийПоСвойствам(Список)
	
	Перем Порядок;
	
	// Порядок.
	Порядок = Список.КомпоновщикНастроек.Настройки.Порядок;
	Порядок.ИдентификаторПользовательскойНастройки = "ОсновнойПорядок";
	
	Порядок.Элементы.Очистить();
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Владелец");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Наименование");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Использование = Истина;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовок()
	
	СтрокаЗаголовка = "";
	
	Если ЗначениеЗаполнено(Свойство) Тогда
		СтрокаЗаголовка = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
			Свойство, "ЗаголовокФормыВыбораЗначения",, ТекущийЯзык().КодЯзыка);
	КонецЕсли;
	
	Если ПустаяСтрока(СтрокаЗаголовка) Тогда
		
		Если ЗначениеЗаполнено(Свойство) Тогда
			Если НЕ Параметры.РежимВыбора Тогда
				СтрокаЗаголовка = НСтр("ru = 'Значения свойства %1'");
			Иначе
				СтрокаЗаголовка = НСтр("ru = 'Выберите значение свойства %1'");
			КонецЕсли;
			
			СтрокаЗаголовка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаЗаголовка, Строка(Свойство));
		
		ИначеЕсли Параметры.РежимВыбора Тогда
			СтрокаЗаголовка = НСтр("ru = 'Выберите значение свойства'");
		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(СтрокаЗаголовка) Тогда
		АвтоЗаголовок = Ложь;
		Заголовок = СтрокаЗаголовка;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияПриИзмененииСвойства()
	
	ПриИзмененииСвойства();
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииСвойства()
	
	Если ЗначениеЗаполнено(Свойство) Тогда
		
		ВладелецДополнительныхЗначений = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
			Свойство, "ВладелецДополнительныхЗначений");
		
		Если ЗначениеЗаполнено(ВладелецДополнительныхЗначений) Тогда
			ТолькоПросмотр = Истина;
			
			ТипЗначения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				ВладелецДополнительныхЗначений, "ТипЗначения");
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, "Владелец", ВладелецДополнительныхЗначений);
			
			ДополнительныеЗначенияСВесом = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				ВладелецДополнительныхЗначений, "ДополнительныеЗначенияСВесом");
		Иначе
			ТолькоПросмотр = Ложь;
			ТипЗначения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Свойство, "ТипЗначения");
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, "Владелец", Свойство);
			
			ДополнительныеЗначенияСВесом = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				Свойство, "ДополнительныеЗначенияСВесом");
		КонецЕсли;
		
		Если ТипЗнч(ТипЗначения) = Тип("ОписаниеТипов")
		   И ТипЗначения.СодержитТип(Тип("СправочникСсылка.ЗначенияСвойствОбъектовИерархия")) Тогда
			
			Элементы.Список.ИзменятьСоставСтрок = Истина;
		Иначе
			Элементы.Список.ИзменятьСоставСтрок = Ложь;
		КонецЕсли;
		
		Элементы.Список.Отображение = ОтображениеТаблицы.ИерархическийСписок;
		Элементы.Владелец.Видимость = Ложь;
		Элементы.Вес.Видимость = ДополнительныеЗначенияСВесом;
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(
			Список, "Владелец");
		
		Элементы.Список.Отображение = ОтображениеТаблицы.Список;
		Элементы.Список.ИзменятьСоставСтрок = Ложь;
		Элементы.Владелец.Видимость = Истина;
		Элементы.Вес.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.Список.Шапка = Элементы.Владелец.Видимость Или Элементы.Вес.Видимость;
	
КонецПроцедуры

#КонецОбласти

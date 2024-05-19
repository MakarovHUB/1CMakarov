///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

 


#Область СлужебныйПрограммныйИнтерфейс

// Параметры:
//  Форма - ФормаКлиентскогоПриложения
//  СвойстваЗаголовка - см. ВариантыОтчетовСлужебный.СтандартныеСвойстваЗаголовкаОтчета
//
Процедура ОпределитьДоступностьДействийКонтекстногоМеню(Форма, СвойстваЗаголовка) Экспорт 
	
	Если ТипЗнч(СвойстваЗаголовка) <> Тип("Структура") Тогда 
		Возврат;
	КонецЕсли;
	
	ДействияКонтекстногоМеню = ДействияКонтекстногоМенюОбластиЗаголовка();
	
	Для Каждого Действие Из ДействияКонтекстногоМеню Цикл 
		Форма.Элементы[Действие.Ключ].Доступность = СвойстваЗаголовка[Действие.Значение];
	КонецЦикла;
	
КонецПроцедуры

Функция КартинкаПоля(ТипЗначенияПоля) Экспорт 
	
	ДоступныеТипы = ?(ТипЗначенияПоля <> Неопределено, ТипЗначенияПоля.Типы(), Новый Массив);
	
	Если ДоступныеТипы.Количество() = 0 Тогда 
		Возврат БиблиотекаКартинок.Пустая;
	КонецЕсли;
	
	Если ДоступныеТипы.Количество() > 1 Тогда 
		Возврат БиблиотекаКартинок.ТипСоставнойОсновной;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Число")) Тогда 
		Возврат БиблиотекаКартинок.ТипЧисло;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Строка")) Тогда 
		Возврат БиблиотекаКартинок.ТипСтрока;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Дата")) Тогда 
		Возврат БиблиотекаКартинок.ТипДата;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Булево")) Тогда 
		Возврат БиблиотекаКартинок.ТипБулево;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("УникальныйИдентификатор")) Тогда 
		Возврат БиблиотекаКартинок.ТипИдентификатор;
	КонецЕсли;
	
	Возврат БиблиотекаКартинок.ТипСсылка;
	
КонецФункции

// Параметры:
//  Поля - ПоляГруппировкиКомпоновкиДанных
//       - ВыбранныеПоляКомпоновкиДанных
//  Поле - ПолеКомпоновкиДанных
//  ПроверятьИспользование - Булево
//  Содержится - Булево
//
// Возвращаемое значение:
//  Булево
//
Функция ПолеСодержитсяВГруппировкеОтчета(Поля, Поле, ПроверятьИспользование = Истина, Содержится = Ложь) Экспорт 
	
	Возврат ПолеОтчета(Поля, Поле, ПроверятьИспользование) <> Неопределено;
	
КонецФункции

// Параметры:
//  Родитель - ГруппировкаКомпоновкиДанных
//           - ГруппировкаТаблицыКомпоновкиДанных
//  Поле - ПолеКомпоновкиДанных
//  Содержится - Булево
//
// Возвращаемое значение:
//  Булево
//
Функция ПолеИспользуетсяВРодительскихГруппировкахОтчета(Родитель, Поле, Содержится = Ложь) Экспорт 
	
	Если (ТипЗнч(Родитель) = Тип("ГруппировкаКомпоновкиДанных")
		Или ТипЗнч(Родитель) = Тип("ГруппировкаТаблицыКомпоновкиДанных")) Тогда 
		
		Если ПолеСодержитсяВГруппировкеОтчета(Родитель.ПоляГруппировки, Поле) Тогда 
			Содержится = Истина;
		Иначе
			ПолеИспользуетсяВРодительскихГруппировкахОтчета(Родитель.Родитель, Поле, Содержится);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Содержится;
	
КонецФункции

// Параметры:
//  Поля - ВыбранныеПоляКомпоновкиДанных
//       - ПоляГруппировкиКомпоновкиДанных
//  Поле - ПолеКомпоновкиДанных
//  ПроверятьИспользование - Булево
//  ПолеОтчета - ВыбранноеПолеКомпоновкиДанных
//             - ПолеГруппировкиКомпоновкиДанных
//             - Неопределено
//
// Возвращаемое значение:
//  ВыбранноеПолеКомпоновкиДанных
//  ПолеГруппировкиКомпоновкиДанных
//  Неопределено
//
Функция ПолеОтчета(Поля, Поле, ПроверятьИспользование = Истина, ЗаголовокПоля = "", ПолеОтчета = Неопределено) Экспорт 
	
	ДоступныеПоля = Неопределено;
	
	Если ТипЗнч(Поля) = Тип("ВыбранныеПоляКомпоновкиДанных") Тогда 
		
		ДоступныеПоля = Поля.ДоступныеПоляВыбора;
		
	ИначеЕсли ТипЗнч(Поля) = Тип("ПоляГруппировкиКомпоновкиДанных") Тогда 
		
		ДоступныеПоля = Поля.ДоступныеПоляПолейГруппировок;
		
	КонецЕсли;
	
	ОписаниеПоля = ?(ДоступныеПоля = Неопределено, Неопределено, ДоступныеПоля.НайтиПоле(Поле));
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ПроверятьИспользование", ПроверятьИспользование);
	ДополнительныеПараметры.Вставить("ЗаголовокПоля", ЗаголовокПоля);
	ДополнительныеПараметры.Вставить("ОписаниеПоля", ОписаниеПоля);
	
	НайтиПолеОтчета(Поля, Поле, ПолеОтчета, ДополнительныеПараметры);
	
	Возврат ПолеОтчета;
	
КонецФункции

Функция РежимВариантаОтчета(КлючВарианта) Экспорт 
	
	Возврат ТипЗнч(КлючВарианта) = Тип("Строка")
		И Не ПустаяСтрока(КлючВарианта);
	
КонецФункции

Функция СвойстваОтбораОбработчикаРасшифровкиПоДетальнымЗаписям() Экспорт 
	
	СвойстваЭлементаОтбора = Новый Структура;
	СвойстваЭлементаОтбора.Вставить("Значение", Неопределено);
	СвойстваЭлементаОтбора.Вставить("ВидСравнения", ВидСравненияКомпоновкиДанных.Равно);
	СвойстваЭлементаОтбора.Вставить("РежимОтображения", РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	СвойстваЭлементаОтбора.Вставить("Представление", "");
	СвойстваЭлементаОтбора.Вставить("ИдентификаторПользовательскойНастройки", "");
	
	Возврат СвойстваЭлементаОтбора;
	
КонецФункции
	
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДействияКонтекстногоМенюОбластиЗаголовка()
	
	Действия = Новый Соответствие;
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаВставитьПолеСправа", "ВставитьПолеСправа");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаВставитьГруппировкуНиже", "ВставитьГруппировкуНиже");
	
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаПереместитьПолеВлево", "ПереместитьПолеВлево");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаПереместитьПолеВправо", "ПереместитьПолеВправо");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаПереместитьПолеВыше", "ПереместитьПолеВыше");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаПереместитьПолеНиже", "ПереместитьПолеНиже");
	
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаСортироватьПоВозрастанию", "СортироватьПоВозрастанию");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаСортироватьПоУбыванию", "СортироватьПоУбыванию");
	
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаСкрытьПоле", "СкрытьПоле");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаПереименоватьПоле", "ПереименоватьПоле");
	
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаОформитьОтрицательные", "ОформитьОтрицательные");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаОформитьПоложительные", "ОформитьПоложительные");
	Действия.Вставить("КонтекстноеМенюОбластиЗаголовкаМенюОформитьЕще", "ОформитьЕще");
	
	Возврат Действия;
	
КонецФункции

#Область Фильтры

// Параметры:
//  Настройки - НастройкиКомпоновкиДанных
//  СвойстваЗаголовка - см. ВариантыОтчетовСлужебный.СтандартныеСвойстваЗаголовкаОтчета
//
Функция ГруппировкаФильтра(Настройки, СвойстваЗаголовка, ЭтоГруппировка = Ложь) Экспорт 
	
	Если СвойстваЗаголовка.ИдентификаторНастроек = Неопределено Тогда 
		Возврат Настройки;
	КонецЕсли;
	
	ИспользуемыеНастройки = Настройки.ПолучитьОбъектПоИдентификатору(
		СвойстваЗаголовка.ИдентификаторНастроек);
	
	Если ИспользуемыеНастройки = Неопределено Тогда 
		ИспользуемыеНастройки = Настройки;
	КонецЕсли;
	
	Если ЭтоГруппировка
		Или СвойстваЗаголовка.ЭтоФормула
		Или СвойстваЗаголовка.КоличествоРазделов > 1 Тогда 
		
		Раздел = ИспользуемыеНастройки.ПолучитьОбъектПоИдентификатору(СвойстваЗаголовка.ИдентификаторРаздела);
	Иначе
		Раздел = ИспользуемыеНастройки;
	КонецЕсли;
	
	Если ТипЗнч(Раздел) = Тип("ТаблицаКомпоновкиДанных") Тогда 
		
		Если СтрНайти(СвойстваЗаголовка.ИдентификаторГруппировки, "/column/") > 0
			И Раздел.Строки.Количество() > 0 Тогда 
			
			Возврат Раздел.Строки[0];
			
		Иначе
			
			Группировка = ИспользуемыеНастройки.ПолучитьОбъектПоИдентификатору(СвойстваЗаголовка.ИдентификаторГруппировки);
			Возврат Группировка;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Раздел;
	
КонецФункции

// Параметры:
//  Настройки - НастройкиКомпоновкиДанных
//  СвойстваЗаголовка - см. ВариантыОтчетовСлужебный.СтандартныеСвойстваЗаголовкаОтчета
//
// Возвращаемое значение:
//  ОтборКомпоновкиДанных
//
Функция ФильтрыРазделаОтчета(Настройки, СвойстваЗаголовка, ЭтоГруппировка = Ложь) Экспорт 
	
	ГруппировкаФильтра = ГруппировкаФильтра(Настройки, СвойстваЗаголовка, ЭтоГруппировка);
	Возврат ГруппировкаФильтра.Отбор;
	
КонецФункции

// Параметры:
//  Фильтры - ОтборКомпоновкиДанных
//  Поле - ПолеКомпоновкиДанных
//  Фильтр - Неопределено
//         - ЭлементОтбораКомпоновкиДанных
//
// Возвращаемое значение:
//  ЭлементОтбораКомпоновкиДанных
//  Неопределено
//
Функция ФильтрРазделаОтчета(Фильтры, Поле, Фильтр = Неопределено) Экспорт 
	
	Для Каждого Элемент Из Фильтры.Элементы Цикл 
		
		Если ТипЗнч(Элемент) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда 
			
			ФильтрРазделаОтчета(Элемент, Поле, Фильтр);
			
		ИначеЕсли Элемент.ЛевоеЗначение = Поле Тогда 
			
			Фильтр = Элемент;
			Прервать;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Фильтр;
	
КонецФункции

#КонецОбласти

#Область ПоискПоля

// Параметры:
//  Поля - ВыбранныеПоляКомпоновкиДанных
//       - ПоляГруппировкиКомпоновкиДанных
//  Поле - ПолеКомпоновкиДанных
//  НайденноеПоле - ВыбранноеПолеКомпоновкиДанных
//                - ПолеГруппировкиКомпоновкиДанных
//                - Неопределено
//
Процедура НайтиПолеОтчета(Поля, Поле, НайденноеПоле, ДополнительныеПараметры)
	
	ПроверятьИспользование = ДополнительныеПараметры.ПроверятьИспользование;
	ЗаголовокПоля = ДополнительныеПараметры.ЗаголовокПоля;
	ОписаниеПоля = ДополнительныеПараметры.ОписаниеПоля;
	
	Для Каждого Элемент Из Поля.Элементы Цикл 
		
		ТипЭлемента = ТипЗнч(Элемент);
		
		ПроверкаИспользованияПоляПройденаУспешно = Не ПроверятьИспользование
			Или ПроверятьИспользование И Элемент.Использование;
		
		ПроверкаЗаголовкаПройденаУспешно = Не ЗначениеЗаполнено(ЗаголовокПоля)
			Или Элемент.Заголовок = ЗаголовокПоля
			Или ОписаниеПоля <> Неопределено И ОписаниеПоля.Заголовок = ЗаголовокПоля;
		
		Если ТипЭлемента <> Тип("АвтоВыбранноеПолеКомпоновкиДанных")
			И Элемент.Поле = Поле
			И ПроверкаИспользованияПоляПройденаУспешно
			И ПроверкаЗаголовкаПройденаУспешно Тогда 
			
			НайденноеПоле = Элемент;
			Возврат;
			
		ИначеЕсли ТипЭлемента = Тип("ГруппаВыбранныхПолейКомпоновкиДанных") Тогда 
			
			НайтиПолеОтчета(Элемент, Поле, НайденноеПоле, ДополнительныеПараметры);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ДанныеЭлементаРасшифровки

Функция ТипЭлементаРасшифровкиГруппировка() Экспорт 
	
	Возврат "Группировка";
	
КонецФункции

#КонецОбласти

Функция ФормулаПоПутиКДанным(Настройки, ПутьКДанным) Экспорт 
	
	Формулы = Настройки.ПользовательскиеПоля.Элементы;
	
	Для Каждого Формула Из Формулы Цикл 
		
		Если СтрЗаканчиваетсяНа(Формула.ПутьКДанным, ПутьКДанным) Тогда 
			Возврат Формула;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция ИндексКартинкиПоля(Знач ТипЗначенияПоля, ЭтоГруппа = Ложь) Экспорт 
	
	Если ЭтоГруппа Тогда 
		Возврат 14;
	КонецЕсли;
	
	Если ТипЗначенияПоля = Неопределено Тогда 
		ТипЗначенияПоля = Новый ОписаниеТипов();
	КонецЕсли;
	
	ДоступныеТипы = ТипЗначенияПоля.Типы();
	
	Если ДоступныеТипы.Количество() = 0 Тогда 
		Возврат -1;
	КонецЕсли;
	
	Если ДоступныеТипы.Количество() > 1 Тогда 
		Возврат 15;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Число")) Тогда 
		Возврат 13;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Строка")) Тогда 
		Возврат 8;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Дата")) Тогда 
		Возврат 2;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("Булево")) Тогда 
		Возврат 0;
	КонецЕсли;
	
	Если ТипЗначенияПоля.СодержитТип(Тип("УникальныйИдентификатор")) Тогда 
		Возврат 4;
	КонецЕсли;
	
	Возврат 16;
	
КонецФункции

Функция МаксимальныйРазмерСтекаНастроек() Экспорт 
	
	Возврат 10;
	
КонецФункции

Функция ИмяСобытияФормыНастроек() Экспорт 
	
	Возврат "ФормаНастроек";
	
КонецФункции

Функция ИмяСобытияИзмененияСоставаБыстрыхНастроек() Экспорт 
	
	Возврат "ИзменитьСоставБыстрыхНастроек";
	
КонецФункции

#КонецОбласти
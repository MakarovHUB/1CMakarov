///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

 


#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы

// Открывает форму со списком отложенных обработчиков
// обновления на текущую версию.
//
Процедура ПоказатьОтложенныеОбработчики() Экспорт
	ОткрытьФорму("Обработка.РезультатыОбновленияПрограммы.Форма.ОтложенныеОбработчики");
КонецПроцедуры

// Конец ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы.
Процедура ПередНачаломРаботыСистемы(Параметры) Экспорт
	
	ПараметрыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если Не ПараметрыКлиента.РазделениеВключено Или Не ПараметрыКлиента.ДоступноИспользованиеРазделенныхДанных Тогда
		ОбновлениеИнформационнойБазыКлиентПереопределяемый.ПриОпределенииВозможностиОбновления(ПараметрыКлиента.ВерсияДанныхОсновнойКонфигурации);
	КонецЕсли;
	
	Если ПараметрыКлиента.Свойство("ИнформационнаяБазаЗаблокированаДляОбновления") Тогда
		Если Не ПараметрыКлиента.ЕстьДоступДляОбновленияВерсииПлатформы
			И ПараметрыКлиента.РазделениеВключено
			И ПараметрыКлиента.ДоступноИспользованиеРазделенныхДанных
			И Не ПараметрыКлиента.Свойство("НеобходимоОбновлениеНеразделенныхДанных") Тогда
			Параметры.Отказ = Истина;
			Параметры.ИнтерактивнаяОбработка = Новый ОписаниеОповещения(
				"ИнициироватьОбновлениеОбласти",
				ЭтотОбъект);
			Возврат;
		КонецЕсли;
		
		Кнопки = Новый СписокЗначений();
		Кнопки.Добавить("Перезапустить", НСтр("ru = 'Перезапустить'"));
		Кнопки.Добавить("Завершить",     НСтр("ru = 'Завершить работу'"));
		
		ПараметрыВопроса = Новый Структура;
		ПараметрыВопроса.Вставить("КнопкаПоУмолчанию", "Перезапустить");
		ПараметрыВопроса.Вставить("КнопкаТаймаута",    "Перезапустить");
		ПараметрыВопроса.Вставить("Таймаут",           60);
		
		ОписаниеПредупреждения = Новый Структура;
		ОписаниеПредупреждения.Вставить("Кнопки",           Кнопки);
		ОписаниеПредупреждения.Вставить("ПараметрыВопроса", ПараметрыВопроса);
		ОписаниеПредупреждения.Вставить("ТекстПредупреждения",
			ПараметрыКлиента.ИнформационнаяБазаЗаблокированаДляОбновления);
		
		Параметры.Отказ = Истина;
		Параметры.ИнтерактивнаяОбработка = Новый ОписаниеОповещения(
			"ПоказатьПредупреждениеИПродолжить",
			СтандартныеПодсистемыКлиент,
			ОписаниеПредупреждения);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы.
Процедура ПередНачаломРаботыСистемы2(Параметры) Экспорт
	
	ПараметрыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если ПараметрыКлиента.Свойство("НеобходимоВыполнитьОбработчикиОтложенногоОбновления") Тогда
		Параметры.ИнтерактивнаяОбработка = Новый ОписаниеОповещения(
			"ИнтерактивнаяОбработкаПроверкиСтатусаОтложенногоОбновления",
			ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы.
Процедура ПередНачаломРаботыСистемы3(Параметры) Экспорт
	
	ПараметрыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если ПараметрыКлиента.Свойство("НеобходимоОбновлениеПараметровРаботыПрограммы") Тогда
		Параметры.ИнтерактивнаяОбработка = Новый ОписаниеОповещения(
			"ЗагрузитьОбновитьПараметрыРаботыПрограммы", ОбновлениеИнформационнойБазыКлиент);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы.
Процедура ПередНачаломРаботыСистемы4(Параметры) Экспорт
	
	ПараметрыРаботыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если НЕ ПараметрыРаботыКлиента.ДоступноИспользованиеРазделенныхДанных Тогда
		ЗакрытьФормуИндикацииХодаОбновленияЕслиОткрыта(Параметры);
		Возврат;
	КонецЕсли;
	
	Если ПараметрыРаботыКлиента.Свойство("НеобходимоОбновлениеИнформационнойБазы") Тогда
		Параметры.ИнтерактивнаяОбработка = Новый ОписаниеОповещения(
			"НачатьОбновлениеИнформационнойБазы", ЭтотОбъект);
	Иначе
		Если ПараметрыРаботыКлиента.Свойство("ЗагрузитьСообщениеОбменаДанными") Тогда
			Перезапустить = Ложь;
			ОбновлениеИнформационнойБазыСлужебныйВызовСервера.ВыполнитьОбновлениеИнформационнойБазы(Истина, Перезапустить);
			Если Перезапустить Тогда
				Параметры.Отказ = Истина;
				Параметры.Перезапустить = Истина;
			КонецЕсли;
		КонецЕсли;
		ЗакрытьФормуИндикацииХодаОбновленияЕслиОткрыта(Параметры);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы.
Процедура ПередНачаломРаботыСистемы5(Параметры) Экспорт
	
	Если ОбщегоНазначенияКлиент.ИнформационнаяБазаФайловая()
	   И СтрНайти(ПараметрЗапуска, "ВыполнитьОбновлениеИЗавершитьРаботу") > 0 Тогда
		
		ПрекратитьРаботуСистемы();
		
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПриНачалеРаботыСистемы.
Процедура ПриНачалеРаботыСистемы(Параметры) Экспорт
	
	ПараметрыРаботыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если НЕ ПараметрыРаботыКлиента.ДоступноИспользованиеРазделенныхДанных Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьОписаниеИзмененийСистемы();
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПослеНачалаРаботыСистемы.
Процедура ПослеНачалаРаботыСистемы() Экспорт
	
	ПараметрыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	
	Если ПараметрыКлиента.Свойство("ПоказатьСообщениеОбОшибочныхОбработчиках")
		Или ПараметрыКлиента.Свойство("ПоказатьОповещениеОНевыполненныхОбработчиках") Тогда
		ПодключитьОбработчикОжидания("ПроверитьСтатусОтложенногоОбновления", 2, Истина);
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//   ФормаОтчета - ФормаКлиентскогоПриложения:
//    * ОтчетТабличныйДокумент - ТабличныйДокумент
//   Команда - КомандаФормы
//   Результат - Булево
// 
Процедура ПриОбработкеКоманды(ФормаОтчета, Команда, Результат) Экспорт
	
	Если ФормаОтчета.НастройкиОтчета.ПолноеИмя = "Отчет.ПрогрессОтложенногоОбновления" Тогда
		Расшифровка = ФормаОтчета.ОтчетТабличныйДокумент.ТекущаяОбласть.Расшифровка;
		Кеш = ФормаОтчета.Отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Кеш");
		КешПриоритетов = ФормаОтчета.Отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("КешПриоритетов");
		ЗначениеРасшифровки = ОбновлениеИнформационнойБазыСлужебныйВызовСервера.ДанныеРасшифровкиОтчета(
			ФормаОтчета.ОтчетДанныеРасшифровки,
			Расшифровка,
			Кеш.Значение,
			КешПриоритетов.Значение);
		
		Если ЗначениеРасшифровки = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		Если Команда.Имя = "ПрогрессОтложенногоОбновленияЗависимости"
			И ЗначениеРасшифровки.ИмяПоля = "ОбработчикОбновления" Тогда
			ОткрытьФорму("Отчет.ПрогрессОтложенногоОбновления.Форма.ЗависимостьОбработчика", ЗначениеРасшифровки);
		ИначеЕсли Команда.Имя = "ПрогрессОтложенногоОбновленияОшибки" Тогда
			ОтборЖурнала = Новый Структура;
			ОтборЖурнала.Вставить("Уровень", "Ошибка");
			ОтборЖурнала.Вставить("СобытиеЖурналаРегистрации", НСтр("ru = 'Обновление информационной базы'", ОбщегоНазначенияКлиент.КодОсновногоЯзыка()));
			ОтборЖурнала.Вставить("ДатаНачала", ЗначениеРасшифровки.НачалоОбновления);
			ЖурналРегистрацииКлиент.ОткрытьЖурналРегистрации(ОтборЖурнала);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Обработчик двойного щелчка мыши, нажатия клавиши Enter или гиперссылки в табличном документе формы отчета.
// См. "Расширение поля формы для поля табличного документа.Выбор" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета          - ФормаКлиентскогоПриложения - форма отчета.
//   Элемент              - ПолеФормы        - табличный документ.
//   Область              - ОбластьЯчеекТабличногоДокумента - выбранное значение.
//   СтандартнаяОбработка - Булево - признак выполнения стандартной обработки события.
//
Процедура ПриОбработкеВыбораТабличногоДокумента(ФормаОтчета, Элемент, Область, СтандартнаяОбработка) Экспорт
	
	Если ФормаОтчета.НастройкиОтчета.ПолноеИмя <> "Отчет.ПрогрессОтложенногоОбновления" Тогда
		Возврат;
	КонецЕсли;
	
	Расшифровка = Область.Расшифровка;
	
	Расшифровка = ФормаОтчета.ОтчетТабличныйДокумент.ТекущаяОбласть.Расшифровка;
	ЗначениеРасшифровки = ОбновлениеИнформационнойБазыСлужебныйВызовСервера.ДанныеРасшифровкиОтчета(
		ФормаОтчета.ОтчетДанныеРасшифровки,
		Расшифровка);
		
	Если ЗначениеРасшифровки <> Неопределено Тогда
		Если ЗначениеРасшифровки.ИмяПоля = "ЕстьОшибки" Тогда
			Значение = ЗначениеРасшифровки.Значение;
			Если Значение.Количество() <> 3 Тогда
				Возврат;
			КонецЕсли;
			
			ЕстьОшибки = Значение[1];
			Если ЕстьОшибки = Истина Тогда
				СтандартнаяОбработка = Ложь;
				ОтборЖурнала = Новый Структура;
				ОтборЖурнала.Вставить("Уровень", "Ошибка");
				ОтборЖурнала.Вставить("СобытиеЖурналаРегистрации", НСтр("ru = 'Обновление информационной базы'", ОбщегоНазначенияКлиент.КодОсновногоЯзыка()));
				ОтборЖурнала.Вставить("ДатаНачала", ЗначениеРасшифровки.НачалоОбновления);
				ЖурналРегистрацииКлиент.ОткрытьЖурналРегистрации(ОтборЖурнала);
			КонецЕсли;
		ИначеЕсли ЗначениеРасшифровки.ИмяПоля = "ПроблемаВДанных" Тогда
			Значение = ЗначениеРасшифровки.Значение;
			Если Значение.Количество() <> 3 Тогда
				Возврат;
			КонецЕсли;
			
			ЕстьОшибки = Значение[2];
			Если ЕстьОшибки = Истина Тогда
				СтандартнаяОбработка = Ложь;
				Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтрольВеденияУчета") Тогда
					МодульКонтрольВеденияУчетаКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("КонтрольВеденияУчетаКлиент");
					МодульКонтрольВеденияУчетаКлиент.ОткрытьОтчетПоПроблемам("ОбновлениеВерсииИБ", Ложь);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура РазблокироватьОбъектДляРедактирования(МассивОбъектов, ДополнительныеПараметры) Экспорт
	
	ТекстВопроса = НСтр("ru = 'Данные объекта заблокированы, т.к. не завершен переход на новую версию программы.
		|Разблокировку рекомендуется применять только в крайних случаях, т.к. данные могут быть записаны некорректно.
		|
		|Разблокировать для редактирования?'");
	Параметры = Новый Структура;
	Параметры.Вставить("МассивОбъектов", МассивОбъектов);
	Параметры.Вставить("Форма", Неопределено);
	Если ДополнительныеПараметры.Свойство("Форма") Тогда
		Параметры.Форма = ДополнительныеПараметры.Форма;
	КонецЕсли;
	ОписаниеОповещения = Новый ОписаниеОповещения("РазблокироватьОбъектДляРедактированияПослеВопроса", ЭтотОбъект, Параметры);
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

Процедура РазблокироватьОбъектДляРедактированияПослеВопроса(Результат, Параметры) Экспорт
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазыСлужебныйВызовСервера.РазблокироватьОбъектДляРедактирования(Параметры.МассивОбъектов);
	
	Если Параметры.Форма <> Неопределено Тогда
		Параметры.Форма.ТолькоПросмотр = Ложь;
		ОчиститьСообщения();
	Иначе
		ТекстСообщения = НСтр("ru = 'Данные разблокированы. Для редактирования необходимо переоткрыть карточку объекта.'");
		ПоказатьПредупреждение(, ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

// Для процедуры ОбновитьИнформационнуюБазу.
Процедура ЗакрытьФормуИндикацииХодаОбновленияЕслиОткрыта(Параметры)
	
	ИмяПараметра = "СтандартныеПодсистемы.ОбновлениеВерсииИБ.ФормаИндикацияХодаОбновленияИБ";
	Форма = ПараметрыПриложения.Получить(ИмяПараметра);
	Если Форма = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Форма.Открыта() Тогда
		Форма.НачатьЗакрытие();
	КонецЕсли;
	ПараметрыПриложения.Удалить(ИмяПараметра);
	
КонецПроцедуры

// Только для внутреннего использования. Продолжение процедуры ОбновитьИнформационнуюБазу.
Процедура НачатьОбновлениеИнформационнойБазы(Параметры, ОбработкаПродолжения) Экспорт
	
	ИмяПараметра = "СтандартныеПодсистемы.ОбновлениеВерсииИБ.ФормаИндикацияХодаОбновленияИБ";
	Форма = ПараметрыПриложения.Получить(ИмяПараметра);
	
	Если Форма = Неопределено Тогда
		ИмяФормы = "Обработка.РезультатыОбновленияПрограммы.Форма.ОбновлениеВерсииПрограммы";
		Форма = ОткрытьФорму(ИмяФормы,,,,,, Новый ОписаниеОповещения(
			"ПослеЗакрытияФормыИндикацияХодаОбновленияИБ", ЭтотОбъект, Параметры));
		ПараметрыПриложения.Вставить(ИмяПараметра, Форма);
	КонецЕсли;
	
	Форма.ОбновитьИнформационнуюБазу();
	
КонецПроцедуры

// Только для внутреннего использования. Продолжение процедуры ПередНачаломРаботыПрограммы.
Процедура ЗагрузитьОбновитьПараметрыРаботыПрограммы(Параметры, Контекст) Экспорт
	
	ИмяФормы = "Обработка.РезультатыОбновленияПрограммы.Форма.ОбновлениеВерсииПрограммы";
	Форма = ОткрытьФорму(ИмяФормы,,,,,, Новый ОписаниеОповещения(
		"ПослеЗакрытияФормыИндикацияХодаОбновленияИБ", ЭтотОбъект, Параметры));
	ПараметрыПриложения.Вставить("СтандартныеПодсистемы.ОбновлениеВерсииИБ.ФормаИндикацияХодаОбновленияИБ", Форма);
	Форма.ЗагрузитьОбновитьПараметрыРаботыПрограммы(Параметры);
	
КонецПроцедуры

// Только для внутреннего использования. Продолжение процедуры ОбновитьИнформационнуюБазу.
Процедура ПослеЗакрытияФормыИндикацияХодаОбновленияИБ(Результат, Параметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Результат = Новый Структура("Отказ, Перезапустить", Истина, Ложь);
	КонецЕсли;
	
	Если Результат.Отказ Тогда
		Параметры.Отказ = Истина;
		Если Результат.Перезапустить Тогда
			Параметры.Перезапустить = Истина;
		КонецЕсли;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(Параметры.ОбработкаПродолжения);
	
КонецПроцедуры

// Только для внутреннего использования. Продолжение процедуры ПроверитьСтатусОбработчиковОтложенногоОбновления.
Процедура ИнтерактивнаяОбработкаПроверкиСтатусаОтложенногоОбновления(Параметры, Контекст) Экспорт
	
	ОткрытьФорму("Обработка.РезультатыОбновленияПрограммы.Форма.ОтложенноеОбновлениеНеЗавершено", , , , , ,
		Новый ОписаниеОповещения("ПослеЗакрытияФормыПроверкиСтатусаОтложенногоОбновления",
			ЭтотОбъект, Параметры));
	
КонецПроцедуры

// Только для внутреннего использования. Продолжение процедуры ПроверитьСтатусОбработчиковОтложенногоОбновления.
Процедура ПослеЗакрытияФормыПроверкиСтатусаОтложенногоОбновления(Результат, Параметры) Экспорт
	
	Если Результат <> Истина Тогда
		Параметры.Отказ = Истина;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(Параметры.ОбработкаПродолжения);
	
КонецПроцедуры

// Если есть непоказанные описания изменения и у пользователя не отключен
// показ - открыть форму ОписаниеИзмененийПрограммы.
//
Процедура ПоказатьОписаниеИзмененийСистемы()
	
	ПараметрыРаботыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если ПараметрыРаботыКлиента.ПоказатьОписаниеИзмененийСистемы Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ПоказыватьТолькоИзменения", Истина);
		
		ОткрытьФорму("ОбщаяФорма.ОписаниеИзмененийПрограммы", ПараметрыФормы);
	КонецЕсли;
	
КонецПроцедуры

// Выводит оповещение пользователю о том, что отложенная обработка данных
// не выполнена.
//
Процедура ОповеститьОтложенныеОбработчикиНеВыполнены() Экспорт
	
	Если ПользователиКлиент.ЭтоСеансВнешнегоПользователя() Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(
		НСтр("ru = 'Работа в программе временно ограничена'"),
		НавигационнаяСсылкаОбработки(),
		НСтр("ru = 'Не завершен переход на новую версию'"),
		БиблиотекаКартинок.Предупреждение32);
	
КонецПроцедуры

// Возвращает навигационную ссылку обработки ОбновлениеИнформационнойБазы.
//
Функция НавигационнаяСсылкаОбработки()
	Возврат "e1cib/app/Обработка.РезультатыОбновленияПрограммы";
КонецФункции

// Только для внутреннего использования. Продолжение процедуры ПередНачаломРаботыСистемы.
Процедура ИнициироватьОбновлениеОбласти(Параметры, ОписаниеПредупреждения) Экспорт
	ОткрытьФорму("Обработка.РезультатыОбновленияПрограммы.Форма.СообщениеДляНеполноправногоПользователя");
КонецПроцедуры

#КонецОбласти

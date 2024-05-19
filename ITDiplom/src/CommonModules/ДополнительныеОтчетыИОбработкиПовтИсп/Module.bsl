///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

 


#Область СлужебныеПроцедурыИФункции

// Виды публикации дополнительных обработок, доступные в программе.
Функция ДоступныеВидыПубликации() Экспорт
	
	Результат = Новый Массив();
	
	Значения = Метаданные.Перечисления.ВариантыПубликацииДополнительныхОтчетовИОбработок.ЗначенияПеречисления;
	ИсключаемыеВидыПубликации = ДополнительныеОтчетыИОбработки.НедоступныеВидыПубликации();
	
	Для Каждого Значение Из Значения Цикл
		Если ИсключаемыеВидыПубликации.Найти(Значение.Имя) = Неопределено Тогда
			Результат.Добавить(Перечисления.ВариантыПубликацииДополнительныхОтчетовИОбработок[Значение.Имя]);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый ФиксированныйМассив(Результат);
	
КонецФункции

// Настройки для формы назначаемого объекта.
Функция ПараметрыФормыНазначаемогоОбъекта(ПолноеИмяФормы, ТипФормы = Неопределено) Экспорт
	Если НЕ ПравоДоступа("Чтение", Метаданные.Справочники.ДополнительныеОтчетыИОбработки) Тогда
		Возврат "";
	КонецЕсли;
	
	Результат = Новый Структура("ЭтоФормаОбъекта, ТипФормы, СсылкаРодителя");
	
	ФормаМетаданные = Метаданные.НайтиПоПолномуИмени(ПолноеИмяФормы);
	Если ФормаМетаданные = Неопределено Тогда
		ПозицияТочки = СтрДлина(ПолноеИмяФормы);
		Пока Сред(ПолноеИмяФормы, ПозицияТочки, 1) <> "." Цикл
			ПозицияТочки = ПозицияТочки - 1;
		КонецЦикла;
		ПолноеИмяРодителя = Лев(ПолноеИмяФормы, ПозицияТочки - 1);
		РодительМетаданные = Метаданные.НайтиПоПолномуИмени(ПолноеИмяРодителя);
	Иначе
		РодительМетаданные = ФормаМетаданные.Родитель();
	КонецЕсли;
	Если РодительМетаданные = Неопределено Или ТипЗнч(РодительМетаданные) = Тип("ОбъектМетаданныхКонфигурация") Тогда
		Возврат "";
	КонецЕсли;
	Результат.СсылкаРодителя = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(РодительМетаданные);
	
	Если ТипФормы <> Неопределено Тогда
		Если ВРег(ТипФормы) = ВРег(ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыОбъекта()) Тогда
			Результат.ЭтоФормаОбъекта = Истина;
		ИначеЕсли ВРег(ТипФормы) = ВРег(ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыСписка()) Тогда
			Результат.ЭтоФормаОбъекта = Ложь;
		Иначе
			Результат.ЭтоФормаОбъекта = (РодительМетаданные.ОсновнаяФормаОбъекта = ФормаМетаданные);
		КонецЕсли;
	Иначе
		Коллекция = Новый Структура("ОсновнаяФормаОбъекта");
		ЗаполнитьЗначенияСвойств(Коллекция, РодительМетаданные);
		Результат.ЭтоФормаОбъекта = (Коллекция.ОсновнаяФормаОбъекта = ФормаМетаданные);
	КонецЕсли;
	
	Если Результат.ЭтоФормаОбъекта Тогда // Форма объекта
		Результат.ТипФормы = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыОбъекта();
	Иначе // Форма списка
		Результат.ТипФормы = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыСписка();
	КонецЕсли;
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

#КонецОбласти

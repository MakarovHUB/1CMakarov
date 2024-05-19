///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////



#Область ПрограммныйИнтерфейс

// Формирует форматную строку согласно "Унифицированному формату электронных банковских сообщений" для ее отображения в
// виде QR-кода.
//
// Параметры:
//  ДанныеДокумента  - Структура - содержит значения полей документа.
//    Данные документа будут закодированы согласно стандарту 
//    "СТАНДАРТЫ ФИНАНСОВЫХ ОПЕРАЦИЙ Символы двумерного штрихового кода для осуществления платежей физических лиц".
//    ДанныеДокумента должны содержать информацию в полях, описанных ниже.
//    Обязательные поля структуры:
//     * ТекстПолучателя             - Строка - наименование получателя платежа, макс. 160 символов;
//     * НомерСчетаПолучателя        - Строка - номер счета получателя платежа, макс. 20 символов;
//     * НаименованиеБанкаПолучателя - Строка - наименование банка получателя платежа, макс. 45 символов;
//     * БИКБанкаПолучателя          - Строка - макс. 9 символов;
//     * СчетБанкаПолучателя         - Строка - номер к/с банка получателя платежа, макс. 20 символов;
//    Дополнительные поля структуры:
//     * СуммаЧислом         - Строка - сумма платежа, в рублях, макс. 16 символов.
//     * НазначениеПлатежа   - Строка - наименование платежа (назначение), макс. 210 символов;
//     * ИННПолучателя       - Строка - ИНН получателя платежа, макс. 12 символов;
//     * ИННПлательщика      - Строка - ИНН плательщика, макс. 12 символов;
//     * СтатусСоставителя   - Строка - статус составителя платежного документа, макс. 2 символа;
//     * КПППолучателя       - Строка - КПП получателя платежа, макс. 9 символов.
//     * КодБК               - Строка - макс. 20 символов;
//     * КодОКТМО            - Строка - код ОКТМО, макс. 11 символов;
//     * ПоказательОснования - Строка - основание налогового платежа, макс. 2 символа;
//     * ПоказательПериода   - Строка - налоговый период, макс. 10 символов;
//     * ПоказательНомера    - Строка - номер документа, макс. 15 символов;
//     * ПоказательДаты      - Строка - дата документа, макс. 10 символ.
//     * ПоказательТипа      - Строка - тип платежа, макс. 2 символа.
//    Прочие дополнительные  поля.
//     * ФамилияПлательщика               - Строка - фамилия плательщика.
//     * ИмяПлательщика                   - Строка - имя плательщика.
//     * ОтчествоПлательщика              - Строка - отчество плательщика.
//     * АдресПлательщика                 - Строка - адрес плательщика.
//     * ЛицевойСчетБюджетногоПолучателя  - Строка - лицевой счет бюджетного получателя.
//     * ИндексПлатежногоДокумента        - Строка - индекс платежного документа.
//     * СНИЛС                            - Строка - № лицевого счета в системе персонифицированного учета в ПФР - СНИЛС.
//     * НомерДоговора                    - Строка - номер договора.
//     * НомерЛицевогоСчетаПлательщика    - Строка - номер лицевого счета плательщика в организации (в системе учета ПУ).
//     * НомерКвартиры                    - Строка - номер квартиры.
//     * НомерТелефона                    - Строка - номер телефона.
//     * ВидПлательщика                   - Строка - вид ДУЛ плательщика.
//     * НомерПлательщик                  - Строка - номер ДУЛ плательщика.
//     * ФИОРебенка                       - Строка - Ф.И.О. ребенка/учащегося.
//     * ДатаРождения                     - Строка - дата рождения.
//     * СрокПлатежа                      - Строка - срок платежа/дата выставления счета.
//     * ПериодОплаты                     - Строка - период оплаты.
//     * ВидПлатежа                       - Строка - вид платежа.
//     * КодУслуги                        - Строка - код услуги/название прибора учета.
//     * НомерПрибораУчета                - Строка - номер прибора учета.
//     * ПоказаниеПрибораУчета            - Строка - показание прибора учета.
//     * НомерИзвещения                   - Строка - номер извещения, начисления, счета.
//     * ДатаИзвещения                    - Строка - дата извещения/начисления/счета/постановления (для ГИБДД).
//     * НомерУчреждения                  - Строка - номер учреждения (образовательного, медицинского).
//     * НомерГруппы                      - Строка - номер группы детсада/класса школы.
//     * ФИОПреподавателя                 - Строка - ФИО преподавателя, специалиста, оказывающего услугу.
//     * СуммаСтраховки                   - Строка - сумма страховки/дополнительной услуги/Сумма пени (в копейках).
//     * НомерПостановления               - Строка - номер постановления (для ГИБДД).
//     * НомерИсполнительногоПроизводства - Строка - номер исполнительного производства.
//     * КодВидаПлатежа                   - Строка - код вида платежа (например, для платежей в адрес Росреестра).
//     * ИдентификаторНачисления          - Строка - уникальный идентификатор начисления.
//     * ТехническийКод                   - Строка - технический код, рекомендуемый для заполнения поставщиком услуг.
//                                          Может использоваться принимающей организацией для вызова соответствующей
//                                          обрабатывающей ИТ-системы.
//                                          Перечень значений кода представлен ниже.
//
//       Код назначения     Наименование назначения платежа
//       платежа.
//       
//          01              Мобильная связь, стационарный телефон.
//          02              Коммунальные услуги, ЖКХ.
//          03              ГИБДД, налоги, пошлины, бюджетные платежи.
//          04              Охранные услуги
//          05              Услуги, оказываемые УФМС.
//          06              ПФР
//          07              Погашение кредитов
//          08              Образовательные учреждения.
//          09              Интернет и ТВ
//          10              Электронные деньги
//          11              Отдых и путешествия.
//          12              Инвестиции и страхование.
//          13              Спорт и здоровье
//          14              Благотворительные и общественные организации.
//          15              Прочие услуги.
//
// Возвращаемое значение:
//   Строка - строка данных в формате УФЭБС.
//
Функция ФорматнаяСтрокаУФЭБС(ДанныеДокумента) Экспорт
	
	ТекстОшибки = "";
	СтрокаОбязательныхРеквизитов = СтрокаОбязательныхРеквизитов(ДанныеДокумента, ТекстОшибки);
	
	Если ПустаяСтрока(СтрокаОбязательныхРеквизитов) Тогда
		ОбщегоНазначения.СообщитьПользователю(ТекстОшибки, , , ,);
		Возврат "";
	КонецЕсли;
	
	СтруктураПредставленийИРеквизитов = СтруктураПредставленийИРеквизитов();
	СтрокаДополнительныхРеквизитов = "";
	ДополнительныеРеквизиты = Новый Структура;
	ДобавитьДополнительныеРеквизиты(ДополнительныеРеквизиты);
	
	Для Каждого Элемент Из ДополнительныеРеквизиты Цикл
		
		Если Не ДанныеДокумента.Свойство(Элемент.Ключ) Тогда
			ДанныеДокумента.Вставить(Элемент.Ключ, "");
			Продолжить;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ДанныеДокумента[Элемент.Ключ]) Тогда
			Если Элемент.Ключ = "СуммаЧислом" Тогда
				ЗначениеСтрокой = Формат(ДанныеДокумента.СуммаЧислом * 100, "ЧГ=");
			Иначе
				ЗначениеСтрокой = СтрЗаменить(СокрЛП(Строка(ДанныеДокумента[Элемент.Ключ])), "|", "");
			КонецЕсли;
			СтрокаДополнительныхРеквизитов = СтрокаДополнительныхРеквизитов + СтруктураПредставленийИРеквизитов[Элемент.Ключ]
			                                 + "=" + ЗначениеСтрокой + "|";
		КонецЕсли;
	КонецЦикла;
	
	Если Не ПустаяСтрока(СтрокаДополнительныхРеквизитов) Тогда
		ДлинаСтроки = СтрДлина(СтрокаДополнительныхРеквизитов);
		СтрокаДополнительныхРеквизитов = Сред(СтрокаДополнительныхРеквизитов, 1, ДлинаСтроки - 1);
	КонецЕсли;

	ПрочиеДополнительныеРеквизиты = Новый Структура;
	ДобавитьПрочиеДополнительныеРеквизиты(ПрочиеДополнительныеРеквизиты);
	СтрокаПрочихДополнительныхРеквизитов = "";
	
	Для Каждого Элемент Из ПрочиеДополнительныеРеквизиты Цикл
		
		Если Не ДанныеДокумента.Свойство(Элемент.Ключ) Тогда
			ДанныеДокумента.Вставить(Элемент.Ключ, "");
			Продолжить;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ДанныеДокумента[Элемент.Ключ]) Тогда
			ЗначениеСтрокой = СтрЗаменить(СокрЛП(Строка(ДанныеДокумента[Элемент.Ключ])), "|", "");
			СтрокаПрочихДополнительныхРеквизитов = СтрокаПрочихДополнительныхРеквизитов
			                                       + СтруктураПредставленийИРеквизитов[Элемент.Ключ] + "=" + ЗначениеСтрокой
			                                       + "|";
		КонецЕсли;
	КонецЦикла;
	
	Если Не ПустаяСтрока(СтрокаПрочихДополнительныхРеквизитов) Тогда
		ДлинаСтроки = СтрДлина(СтрокаПрочихДополнительныхРеквизитов);
		СтрокаПрочихДополнительныхРеквизитов = Сред(СтрокаПрочихДополнительныхРеквизитов, 1, ДлинаСтроки - 1);
	КонецЕсли;
	
	ИтоговаяСтрока = СтрокаОбязательныхРеквизитов
	                 + ?(ПустаяСтрока(СтрокаДополнительныхРеквизитов), "", "|" + СтрокаДополнительныхРеквизитов)
	                 + ?(ПустаяСтрока(СтрокаПрочихДополнительныхРеквизитов), "", "|" + СтрокаПрочихДополнительныхРеквизитов);
	
	Возврат ИтоговаяСтрока;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтрокаОбязательныхРеквизитов(ДанныеДокумента, ТекстСообщения)
	
	ОбязательныеРеквизиты = Новый Структура();
	СтруктураПредставленийИРеквизитов = СтруктураПредставленийИРеквизитов();
	ДобавитьОбязательныеРеквизиты(ОбязательныеРеквизиты);
	
	Если Не ЗначениеЗаполнено(ДанныеДокумента.СчетБанкаПолучателя) Тогда
		ДанныеДокумента.СчетБанкаПолучателя = "0";
	КонецЕсли;
	
	СлужебныеДанные = "ST00012";
	ОбязательныеДанные = "";
	
	Для Каждого Элемент Из ОбязательныеРеквизиты Цикл
		Если Не ЗначениеЗаполнено(ДанныеДокумента[Элемент.Ключ]) Тогда
			ТекстСообщения = НСтр("ru = 'Не заполнен обязательный реквизит: %1'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, Элемент.Ключ);
			Возврат "";
		КонецЕсли;
		
		ЗначениеСтрокой = СтрЗаменить(СокрЛП(Строка(ДанныеДокумента[Элемент.Ключ])), "|", "");
		
		ОбязательныеДанные = ОбязательныеДанные + "|" + СтруктураПредставленийИРеквизитов[Элемент.Ключ] + "="
		                     + ЗначениеСтрокой;
		
	КонецЦикла;
	
	Если СтрДлина(ОбязательныеДанные) > 300 Тогда
		Шаблон = НСтр("ru = 'Невозможно создать QR-код для документа %1
			|Строка обязательных реквизитов должна быть меньше 300 символов:
			|""%2""'");
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Шаблон, ДанныеДокумента.Ссылка, ОбязательныеДанные);
		Возврат "";
	КонецЕсли;
	
	Возврат СлужебныеДанные + ОбязательныеДанные;
	
КонецФункции

Функция СтруктураПредставленийИРеквизитов()
	
	СтруктураВозврата = Новый Структура();
	
	СтруктураВозврата.Вставить("ТекстПолучателя",             "Name");
	СтруктураВозврата.Вставить("НомерСчетаПолучателя",        "PersonalAcc");
	СтруктураВозврата.Вставить("НаименованиеБанкаПолучателя", "BankName");
	СтруктураВозврата.Вставить("БИКБанкаПолучателя",          "BIC");
	СтруктураВозврата.Вставить("СчетБанкаПолучателя",         "CorrespAcc");
	
	СтруктураВозврата.Вставить("СуммаЧислом",         "Sum");
	СтруктураВозврата.Вставить("НазначениеПлатежа",   "Purpose");
	СтруктураВозврата.Вставить("ИННПолучателя",       "PayeeINN");
	СтруктураВозврата.Вставить("ИННПлательщика",      "PayerINN");
	СтруктураВозврата.Вставить("СтатусСоставителя",   "DrawerStatus");
	СтруктураВозврата.Вставить("КПППолучателя",       "KPP");
	СтруктураВозврата.Вставить("КодБК",               "CBC");
	СтруктураВозврата.Вставить("КодОКТМО",            "OKTMO");
	СтруктураВозврата.Вставить("ПоказательОснования", "PaytReason");
	СтруктураВозврата.Вставить("ПоказательПериода",   "TaxPeriod");
	СтруктураВозврата.Вставить("ПоказательНомера",    "DocNo");
	СтруктураВозврата.Вставить("ПоказательДаты",      "DocDate");
	СтруктураВозврата.Вставить("ПоказательТипа",      "TaxPaytKind");
	
	СтруктураВозврата.Вставить("ФамилияПлательщика",               "lastName");
	СтруктураВозврата.Вставить("ИмяПлательщика",                   "firstName");
	СтруктураВозврата.Вставить("ОтчествоПлательщика",              "middleName");
	СтруктураВозврата.Вставить("АдресПлательщика",                 "payerAddress");
	СтруктураВозврата.Вставить("ЛицевойСчетБюджетногоПолучателя",  "personalAccount");
	СтруктураВозврата.Вставить("ИндексПлатежногоДокумента",        "docIdx");
	СтруктураВозврата.Вставить("СНИЛС",                            "pensAcc");
	СтруктураВозврата.Вставить("НомерДоговора",                    "contract");
	СтруктураВозврата.Вставить("НомерЛицевогоСчетаПлательщика",    "persAcc");
	СтруктураВозврата.Вставить("НомерКвартиры",                    "flat");
	СтруктураВозврата.Вставить("НомерТелефона",                    "phone");
	СтруктураВозврата.Вставить("ВидПлательщика",                   "payerIdType");
	СтруктураВозврата.Вставить("НомерПлательщика",                 "payerIdNum");
	СтруктураВозврата.Вставить("ФИОРебенка",                       "childFio");
	СтруктураВозврата.Вставить("ДатаРождения",                     "birthDate");
	СтруктураВозврата.Вставить("СрокПлатежа",                      "paymTerm");
	СтруктураВозврата.Вставить("ПериодОплаты",                     "paymPeriod");
	СтруктураВозврата.Вставить("ВидПлатежа",                       "category");
	СтруктураВозврата.Вставить("КодУслуги",                        "serviceName");
	СтруктураВозврата.Вставить("НомерПрибораУчета",                "counterId");
	СтруктураВозврата.Вставить("ПоказаниеПрибораУчета",            "counterVal");
	СтруктураВозврата.Вставить("НомерИзвещения",                   "quittId");
	СтруктураВозврата.Вставить("ДатаИзвещения",                    "quittDate");
	СтруктураВозврата.Вставить("НомерУчреждения",                  "instNum");
	СтруктураВозврата.Вставить("НомерГруппы",                      "classNum");
	СтруктураВозврата.Вставить("ФИОПреподавателя",                 "specFio");
	СтруктураВозврата.Вставить("СуммаСтраховки",                   "addAmount");
	СтруктураВозврата.Вставить("НомерПостановления",               "ruleId");
	СтруктураВозврата.Вставить("НомерИсполнительногоПроизводства", "execId");
	СтруктураВозврата.Вставить("КодВидаПлатежа",                   "regType");
	СтруктураВозврата.Вставить("ИдентификаторНачисления",          "uin");
	СтруктураВозврата.Вставить("ТехническийКод",                   "TechCode");
	
	Возврат СтруктураВозврата;
	
КонецФункции

Процедура ДобавитьОбязательныеРеквизиты(СтруктураДанных)
	
	СтруктураДанных.Вставить("ТекстПолучателя");
	СтруктураДанных.Вставить("НомерСчетаПолучателя");
	СтруктураДанных.Вставить("НаименованиеБанкаПолучателя");
	СтруктураДанных.Вставить("БИКБанкаПолучателя");
	СтруктураДанных.Вставить("СчетБанкаПолучателя");
	
КонецПроцедуры

Процедура ДобавитьДополнительныеРеквизиты(СтруктураДанных)
	
	СтруктураДанных.Вставить("СуммаЧислом");
	СтруктураДанных.Вставить("НазначениеПлатежа");
	СтруктураДанных.Вставить("ИННПолучателя");
	СтруктураДанных.Вставить("ИННПлательщика");
	СтруктураДанных.Вставить("СтатусСоставителя");
	СтруктураДанных.Вставить("КПППолучателя");
	СтруктураДанных.Вставить("КодБК");
	СтруктураДанных.Вставить("КодОКТМО");
	СтруктураДанных.Вставить("ПоказательОснования");
	СтруктураДанных.Вставить("ПоказательПериода");
	СтруктураДанных.Вставить("ПоказательНомера");
	СтруктураДанных.Вставить("ПоказательДаты");
	СтруктураДанных.Вставить("ПоказательТипа");
	
КонецПроцедуры

Процедура ДобавитьПрочиеДополнительныеРеквизиты(СтруктураДанных)
	
	СтруктураДанных.Вставить("ФамилияПлательщика");
	СтруктураДанных.Вставить("ИмяПлательщика");
	СтруктураДанных.Вставить("ОтчествоПлательщика");
	СтруктураДанных.Вставить("АдресПлательщика");
	СтруктураДанных.Вставить("ЛицевойСчетБюджетногоПолучателя");
	СтруктураДанных.Вставить("ИндексПлатежногоДокумента");
	СтруктураДанных.Вставить("СНИЛС");
	СтруктураДанных.Вставить("НомерДоговора");
	СтруктураДанных.Вставить("НомерЛицевогоСчетаПлательщика");
	СтруктураДанных.Вставить("НомерКвартиры");
	СтруктураДанных.Вставить("НомерТелефона");
	СтруктураДанных.Вставить("ВидПлательщика");
	СтруктураДанных.Вставить("НомерПлательщика");
	СтруктураДанных.Вставить("ФИОРебенка");
	СтруктураДанных.Вставить("ДатаРождения");
	СтруктураДанных.Вставить("СрокПлатежа");
	СтруктураДанных.Вставить("ПериодОплаты");
	СтруктураДанных.Вставить("ВидПлатежа");
	СтруктураДанных.Вставить("КодУслуги");
	СтруктураДанных.Вставить("НомерПрибораУчета");
	СтруктураДанных.Вставить("ПоказаниеПрибораУчета");
	СтруктураДанных.Вставить("НомерИзвещения");
	СтруктураДанных.Вставить("ДатаИзвещения");
	СтруктураДанных.Вставить("НомерУчреждения");
	СтруктураДанных.Вставить("НомерГруппы");
	СтруктураДанных.Вставить("ФИОПреподавателя");
	СтруктураДанных.Вставить("СуммаСтраховки");
	СтруктураДанных.Вставить("НомерПостановления");
	СтруктураДанных.Вставить("НомерИсполнительногоПроизводства");
	СтруктураДанных.Вставить("КодВидаПлатежа");
	СтруктураДанных.Вставить("ИдентификаторНачисления");
	СтруктураДанных.Вставить("ТехническийКод");
	
КонецПроцедуры

#КонецОбласти

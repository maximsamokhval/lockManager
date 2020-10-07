﻿#Область ОбработчикиСобытийФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Заблокировать(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		ЗаблокироватьОбъектНаСервере();
		ПодключитьОбработчикОжидания(ИмяОбработчика(),Объект.ВремяОжидания,Ложь);	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Разблокировать(Команда)
	ОтключитьОбработчикОжидания(ИмяОбработчика());
КонецПроцедуры

&НаКлиенте
Процедура ОстановитьВсеБлокировки(Команда)
	ОстановитьВсеБлокировкиНаСервере();
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ИмяОбработчика()
	Возврат "Подключаемый_ЗаблокироватьОбъекты"; 
КонецФункции

&НаКлиенте
Процедура Подключаемый_ЗаблокироватьОбъекты()
	
	Если ПроверитьЗаполнение() Тогда
		ЗаблокироватьОбъектНаСервере();
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ЗаблокироватьОбъектНаСервере()
	
	ОбработкаОбъект = ОбработкаОбъект();
	МассивОбъектов 	= Новый Массив;
	МассивОбъектов.Добавить(Объект.ОбъектБлокировки);
	
	ЗаблокированыДругимПользователем = ОбработкаОбъект.Заблокировать(МассивОбъектов, Объект.ВремяОжидания);
	
	Если ЗаблокированыДругимПользователем.Количество() Тогда
		
		Информация = "";
		
		МассивЗаблокированных = Новый Массив;
		Для каждого ЭлеметБлокировки Из ЗаблокированыДругимПользователем Цикл
			
			МассивЗаблокированных.Добавить(Строка(ЭлеметБлокировки));
					
		КонецЦикла; 
		
		Информация = СтрСоединить(МассивЗаблокированных,Символы.ПС);
		
	КонецЕсли; 
	
	
КонецПроцедуры

&НаСервере
Процедура ОстановитьВсеБлокировкиНаСервере()
	
	ОбработкаОбъект = ОбработкаОбъект();
	ОбработкаОбъект.СнятьВсеБлокировки();
	
КонецПроцедуры

&НаСервере
Функция ОбработкаОбъект()	
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
 

#КонецОбласти
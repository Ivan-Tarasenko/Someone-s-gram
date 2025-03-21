<div align="center">
<br>
<h1>Someone's gram <img src="/Preview/icon.png" width="50" height="50" hspace="10"/></h1> 
</div>

<div align="center">
<h4>Любая социальная сеть выглядит как то так.</h4>
</div>

<p align="center">
<img src="/Preview/Homescreen.png" width="149" height="300"/>
<img src="/Preview/Launchscreen.png" width="149" height="300"/>
<img src="/Preview/Loadscreen.png" width="149" height="300"/>
<img src="/Preview/Mainscreen.png" width="149" height="300"/>
<img src="/Preview/Detailscreen.png" width="149" height="300"/>
</p>

## Описание проекта

Приложение разработано в классической архитектуре MVC, с разделением на экраны, каждый из которых находится в отдельной папке. Я выбрал MVC, поскольку данная архитектура проста в изучении и идеально подходит для небольших проектов. В данном случае приложение не превышает пяти экранов, поэтому использование более сложных архитектур, таких как VIPER, было бы избыточным. Кроме того, MVC упрощает навигацию по проекту, так как нет необходимости просматривать множество папок в поисках нужных файлов.

Тем не менее, для лучшей организации кода я вынес управление таблицей в отдельные файлы. Это позволило избежать нагромождения всех делегатов UITableView в одном месте и повысило читаемость кода.

Используемые технологии и подходы

При разработке приложения я использовал несколько паттернов проектирования. В частности, Singleton применялся для классов, доступ к которым необходим из разных частей приложения. Это позволило избежать многократной инициализации и упростить работу с глобальными сервисами.

Для реализации имитации ленты социальной сети я выбрал API Unsplash. Этот сервис удобен тем, что в одном запросе можно получить сразу несколько параметров:
    •    аватар и имя пользователя,
    •    основное изображение,
    •    количество лайков под этим изображением.

Работа с сетью и данными

Сетевые запросы выполняются с помощью Alamofire, а для кэширования изображений используется библиотека AlamofireImage. После получения данных они сохраняются в локальную базу Core Data, что позволяет загружать контент даже в режиме офлайн.

Дополнительные замечания

Так как у меня нет платной подписки разработчика, приложение можно запускать только в симуляторе Xcode.

Рекомендую загружать приложение из ветки Main, так как ветка Preview содержит дополнительные изображения, предназначенные для демонстрации на странице GitHub.

## Автор
Ivan Tarasenko  
**telegram (@Ivan_iOS_Developer)**

## stack
MVC  
UIKit  
CoreData  
Alamofire  

<p align="center">
<a href="https://github.com/realm/SwiftLint" alt="SwiftLint badge">
<img src="https://img.shields.io/badge/CodeStyle-SwiftLint-blueviolet"></a>
<a href="https://github.com/Ivan-Tarasenko/Someone-s-gram/blob/main/LICENSE.txt">
<img src="https://img.shields.io/badge/license-MIT-green?style=flat"></a>
<a><img src="https://img.shields.io/github/commit-activity/y/Ivan-Tarasenko/Someone-s-gram"></a>
<a><img src="https://img.shields.io/github/directory-file-count/Ivan-Tarasenko/Someone-s-gram"></a>
<a><img src="https://img.shields.io/github/repo-size/Ivan-Tarasenko/Someone-s-gram"></a>
<a><img src="https://img.shields.io/github/issues-pr-closed/Ivan-Tarasenko/Someone-s-gram?color=yellowgreen"></a>
<a><img src="https://img.shields.io/badge/language-Swift%205-orange.svg"></a>
</p>


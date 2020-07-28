# MyAxxessApp
This application fetches all records from an API. The fetched records are displayed in Tabular format. On clicking a record we can see its detail on Detailed View Controller. Following features are available in application -
1) Get Records from API and display them in taular form.
2) Clicking a record will show it in a detailed screen.
3) Records will be saved using Realm DB for offline usage.
4) There is a filter to sort records based on Type. Filters are None, Text & Image. By default none is selected which displays record in random order.
5) Used Alamofire for Networking API's
6) Used Snapkit for creating constraints on UI elements.
7) Used Reachability to check for internet connectivity.

Steps to Run this application - 
1) Download or clone this repository.
2) Navigate to root folder of project on command line terminal.
3) Run pod install.
4) Open the workspace file.
5) Change the swift version of installed pods like Alamofire, ObjectMapper to Swift Language Version - 4.2
6) Build the project

Test Cases - 
1) Rocords are fetched from API or not. 
2) Records are properly displayed or not.
3) Records are Filtered based on Type or not.
4) Clicking on a record shopuld show detailed screen.
5) If content on detailed screen is larger than screen size than it should be vertically scrollable.
6) Records should be fetched when running in active internet connection
7) Records should be persisted on DB
8) If app is running under no network condition than records should be displayed from DB(if records are there in DB).
9) Cells should be be updated as soon as there image is dowloaded.
10) Scrolling should be smooth.

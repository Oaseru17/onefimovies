# onefimovies
Name : Precious Osaro
Date: 7th March 2019
Email: preciousoaseru993@gmail.com

/** A video of application in session is attached**/
/** Please any feedback on poor coding style, or better approach or solution will be highly appreciated**/


Solution Structure : App uses MVVM design

Application supports iPad/iphone
Application supports landscape and portrait mode

Folder description
- datastructure : Houses all datastructure used within the application
- seed: Houses the helper and seed data (the list of movies to read in text file) need.
- database : Holds the database helper class
- font: holds the fonts used in application
- appsettings: houses all extension, settings, webapiconstant and datamanger classes
- view: this is where all app location and view are kept using a single folder per page approach. Folder for each view  holds webcontroller.file(optional), model, viewmodel and controller, and any other subview xib files.
- Image: holds the images used withing application
- Assests : any other assest need
- Story board: Houses all storyboard in application

Functionality
- Intro : a simple app introduction 
- List movie: list movies or series
- Details on movies: details of each movie/series
- Search: search through the catalog of movies by title

Libraries
Note: as a personal view, I go against using 3rd party libraries for sensitive sections of application example network requests, though libraries like alamofire are very useful as they hold various features and are well maintained, but still with the rapid change in swift , one maybe be left with waiting on changes from provider before bugs are fixed within application.
Futhermore, network security features by SSL pinning am less comfortable trusting third party libraries 
Saying  these, third party libraries that are restricted to UI/UX are a feature in my application, as they improve the general application

A great UI/UX but bugged fixed application can get the patience of users
A poor UI/UX but perfect application is that mercy of competitors 


Libraries used
 'Mockingjay used during UI testing for network, required as during ui testing networking connectivity.
'SwiftyJSON' required to read api data as JSON 'Kingfisher' required for smooth lazy loading, memory cache management (expiration duration, image count limit, and cache size are main features)
'SkeletonView' add a smooth loading animation on table cell


Testing
Few UITesting and Unittesting performed

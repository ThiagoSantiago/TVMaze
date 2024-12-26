# TVMaze App

[![codebeat badge](https://codebeat.co/badges/2221c4ab-8918-4a45-baa1-8d8da6bc2ea1)](https://codebeat.co/projects/github-com-thiagosantiago-tvmaze-main)

## Project Features

#### Mandatory features

- [x] Show the list of all series contained in the API used by the paging scheme provided by the
API.
- [x] Allow users to search series by name.
- [x] Present for each listed serie the poster, name, status and one more info regarding the status (premier or ended).
- [X] Show the details of the series, showing name, poster, schedule with days and time, genres, summary and the list of episodes separated by season.
- [x] Show the episode’s information, including: name, number, season, summary and image, if there is one.
      
#### Bonus features

- [x] Allow the user to set a PIN number to secure the application and prevent unauthorized
users. 
- [X] For supported phones, the user must be able to choose if they want to enable biometric
authentication to avoid typing the PIN number while opening the app.
- [X] Allow the user to save a series as a favorite.
- [X] Allow the user to delete a series from the favorites list.
- [X] Allow the user to browse their favorite series in alphabetical order, and click on one to
see its details.
- [X] Create a people search by listing the name and image of the person.
- [ ] After clicking on a person, the application should show the details of that person, such as: name, image and series they have participated in, with a link to the series details.

## Unit Tests

- TVMazeApp: **100%** of code coverage
- TVMazeApiError: **100%** of code coverage
- LoginView: **70%** of code coverage
- SerieDetailsViewModel: **87.6%** of code coverage
- SeriesListViewModel: **88.1%** of code coverage

- **Total Project Coverage: 11.3%**

## Code Quality

- To keep the code quality I'm using the [**Codebeat**](https://codebeat.co)
- `Codebeat` provides automated code review helping you to easily identify weakness and code smells in your app.
- The `Codebeat` label at this readme file shows the code quality of the app.

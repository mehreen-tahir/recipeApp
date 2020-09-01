# Overview
Ruby on rails application using Contentful API.

# Running pre-requiste
Create .env file in root directory. Add the required fields *SPACE_KEY*, *ACCESS_TOKEN*, *ENV_ID* as key-value pair in it.

```
SPACE_KEY=randomkey
ACCESS_TOKEN=randomtoken
ENV_ID=env
```
# Running application
The application is supported with basic docker setup. After clonning the repository, steps to execute the app in dockerized envoirnment are

1. Build the docker image by running.
```
docker build -t recipeapp .
```
2. Run the docker on respective port and supply .env file created in pre-requiste step. 
```
docker run -e .env -p 3000:3000 -v $(pwd):/usr/src/app/ recipeapp
```
3. The server should be up and running at `http://localhost:3000/`.

# Implementation details
The web application concentrates on providing endpoints using services, for fetching data from Contentful API to fetch all recipes based upon their creation and individual recipe details from the Contentful space.  

- Both HTML & JSON formats are supported for endpoints.
   - Recipe listing page (`/recipe`)
   - Recipe detail page (`/recipes/:id`)

All the views make use of bootstrap and jquery for card based basic minimal styling.

# Running tests
The application is supported with basic unit and functional testing using Rspec. 

The tests coverage can be seen by running `rspec` for the entire app or indiviudal files.

# Enhancements
- In dockerization
  - Instead of using simple docker run command, I would prefer to extend it by using `docker-compose`.
- In application.
  - Depends upon the view requirment and data quantity, I would prefer to use 'pagination' (supported by the gem as well) to decrease response time if we have quite much recipes. It would provide us the benefit of fetching items in chuncks and display maybe by implementing simple pagination or infinite scroll or anything else around those lines.
  - Views / UI desgins are not super nice :D would definately like to improve it further by integeating custom themes etc.
- In testing.
  - I would like to integerate FakeWeb to avoid test envoirnments requests going to third-party API. Rather, I would like the test environment requests to be served from within. Obuisally it will have the need to be maintained if third party aka Contentful changes the API response but it will highly reduce the number of API requests hitting the contentful API for testing.

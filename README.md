# Flix

# Project 1 - *Flix*

**Flix** is a great way to keep yourself updated on the most recent and popular movies.

Submitted by: **Sumedha Mehta**

Time spent: **~16** hours spent in total

## User Stories

The following **required** functionality is complete:

*  User can view a list of movies currently playing in theaters from The Movie Database (title, poster image, and overview).
*  Poster images are loaded using the UIImageView category in the AFNetworking library.
*  The movie poster is available by appending the returned poster_path to https://image.tmdb.org/t/p/w342.
*  User sees a loading state while waiting for the movies API (you can use any 3rd party library available to do this).
*  User can pull to refresh the movie list.

The following **optional** features are implemented:
* [ ] User sees an error message when there's a networking error. You may not use UIAlertController or a 3rd party library to display the error. See this screenshot for what the error message should look like.
*  Movies are displayed using a CollectionView instead of a TableView.
*  User can search for a movie.
* [ ] All images fade in as they are loading.
*  User can view the large movie poster by tapping on a cell.
* [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
* [ ] Customize the selection effect of the cell.
*  Customize the navigation bar.
*  Customize the UI. You can use Iconmonstr and The Noun Project as good sources of images.

The following **additional** features are implemented:

-  Displayed the # of stars based on the rating
-  Linked each movie to IMDb page
-  Had a details page for each movie

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://www.i.imgur.com/7XvcDWc/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2016 Sumedha Mehta

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# TVShows

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

A Swift iOS TV Shows app. An application built solely for study purposes. The app brings a list of TV shows, cast, seasons, episodes and details. And you can save and remove TV Shows from the favorites list.


| Demo | Details | List |
| --- | --- | --- |
| ![Demo](https://github.com/user-attachments/assets/ac075e7e-94f0-4f4f-90a3-9497dfadf396) | ![Details](https://github.com/user-attachments/assets/71dda156-8094-485e-846c-8c101c33eeca) | ![List](https://github.com/user-attachments/assets/bbe74904-703b-4305-8b99-a14af9eb8f6e) |


## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Setup](#setup)

## Features

- View Code (UIKit)
- Modern CollectionView Diffable
- Modern TableView Diffable
- UserDefaults
- Custom elements
- Pagination
- Dark Mode
- MVVM with Combine
- Await/Async Request
- UserDefults
- Unit Tests

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities

- [x] **TV Shows List**: Displays a list of available TV shows for viewing.
- [x] **Pagination**: Implements pagination in the TV shows list to efficiently load and display content as the user scrolls.
- [x] **TV Show Details**: Tapping on a show takes the user to a detailed screen with information about the cast, seasons, and episodes.
- [x] **Favorite TV Shows**: Allows the user to favorite a TV show. This is done using `UserDefaults` to store the favorite shows.
- [x] **Favorites Page**: Displays all TV shows that the user has favorited. From this page, users can also access the details of each show.
- [x] **Remove from Favorites**: From the favorites page, users can remove shows from their favorites list.
- [x] **Dark Mode Support**: Full support for Dark Mode, offering a more pleasant user experience in different lighting conditions.
- [x] **UIKit Interface**: Utilizes UIKit components for building the user interface.
- [x] **Modern Collections**: Implements `UICollectionViewDiffableDataSource` to optimize data management and UI updates.


## Setup

First of all download and install Xcode, Swift Package Manager and then clone the repository:

```sh
$ git@github.com:diggosilva/TVShows.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/TVShows/
$ open TVShows.xcodeproj/
```

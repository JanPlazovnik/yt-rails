# YouTube Clone

YouTube Clone is a web app I made as a school project. The app features most of the basic features such as exploring, uploading, rating, subscribing, etc. FFmpeg is used to generate thumbnails for uploads that don't include their own.

## Installation

Use [git](https://git-scm.com/) to clone the repository.

```git
git clone https://github.com/JanPlazovnik/yt-rails.git
```

Afterwards run: `bundle install` and `yarn install`.

Next you'll need to modify the `/config/database.yml` file. Once done, create your database and run migrations.
```
$ rails db:create
$ rails db:migrate
```

## Usage

All that's left is to run the server.
```
$ rails s
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)

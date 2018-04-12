# Vails

Ultra simple video server application for home use.

- You can manage your video by tag.
- Digest thumbnail make easy to search videos.

## Limitation

I tested only with videso encoded as h264. With videos encoded as other codec might not work correctly.

## Usage

### Install

```
$ docker-compose build
$ docker-compose run app bundle exec rake db:setup
$ docker-compose run app bundle exec rake assets:precompile
```

### Run server
```
$ docker-compose up
```

### Import videos

First, place your videos in `import ` directory. And ensure server is running.
Then, run

```
$ docker-compose run app bundle exec rake import_videos:do
```

Importing video takes very long time if video is long. Please be patient!

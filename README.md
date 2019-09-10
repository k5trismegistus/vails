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

### Deploy

Fill /deploy/.env

Only deploy code change

```
$ docker-compose run --rm deploy fab deploy
```

When assets new gem added or assets precompile needed

```
$ docker-compose run --rm deploy fab rebuild
```

When docker image rebuild required

```
$ docker-compose run --rm deploy fab rebuildimage
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

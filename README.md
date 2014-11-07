# docker-postgresql

PostgreSQL Docker Image

## Tags

* `latest` - The repo's master branch - WIP :dragon_face:
* `9.4` - PostgreSQL 9.4 from Ubuntu's Utopic repository
* `9.3` - Latest PostgreSQL 9.3 from apt.postgresql.org (on Ubuntu Trusty)

## Usage

1. Run this image, e.g.
  `docker run -d --name postgresql zumbrunnen/postgresql:9.4`
2. Connect to it via link or with `psql`:

```
psql -h <containerip> -U docker
docker run -d -link postgresql:db <otherimage>
```
Use `docker` as username and password.

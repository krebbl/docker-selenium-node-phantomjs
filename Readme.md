# Selenium Grid Node - PhantomJS

A docker image of PhantomJS 2.1.1 / GhostDriver that's compatible with selenium grid hub 

This version of PhantomJS has been patched to fix [ghostdriver/#394](https://github.com/detro/ghostdriver/issues/394)

## Dockerfile

[`krebbl/selenium-node-phantomjs` Dockerfile](https://github.com/krebbl/docker-selenium-node-phantomjs/blob/master/Dockerfile)

## How to use this image

First, you will need a Selenium Grid Hub that the Node will connect to.

```
$ docker run -d -P --name selenium-hub selenium/hub
```

Once the hub is up and running will want to launch nodes that can run tests. You can run as many nodes as you wish.

```
$ docker run -d --link selenium-hub:hub krebbl/selenium-node-phantomjs
```

Use PHANTOMJS_OPTS environment variable to pass additional command line options to the phantomjs node. For example to ignore SSL errors:
```
$ docker run -d -e "PHANTOMJS_OPTS=--ignore-ssl-errors=true" --link selenium-hub:hub krebbl/selenium-node-phantomjs

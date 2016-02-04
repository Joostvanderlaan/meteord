[![Circle CI](https://circleci.com/gh/Joostvanderlaan/meteord.svg?style=svg)](https://circleci.com/gh/Joostvanderlaan/meteord)

base [![base](https://badge.imagelayers.io/joostlaan/meteord:base.svg)](https://imagelayers.io/?images=joostlaan/meteord:base 'base')
binbuild [![binbuild](https://badge.imagelayers.io/joostlaan/meteord:binbuild.svg)](https://imagelayers.io/?images=joostlaan/meteord:binbuild 'binbuild')
devbuild [![devbuild](https://badge.imagelayers.io/joostlaan/meteord:devbuild.svg)](https://imagelayers.io/?images=joostlaan/meteord:devbuild 'Get your own badge on imagelayers.io')
distbuild[![distbuild](https://badge.imagelayers.io/joostlaan/meteord:distbuild.svg)](https://imagelayers.io/?images=joostlaan/meteord:distbuild 'Get your own badge on imagelayers.io')
onbuild[![onbuild](https://badge.imagelayers.io/joostlaan/meteord:onbuild.svg)](https://imagelayers.io/?images=joostlaan/meteord:onbuild 'Get your own badge on imagelayers.io')
testbuild[![testbuild](https://badge.imagelayers.io/joostlaan/meteord:testbuild.svg)](https://imagelayers.io/?images=joostlaan/meteord:testbuild 'Get your own badge on imagelayers.io')


#### Changes by Joost

#### Notes
docker build -t joostlaan/meteord:base ./base
docker build -t joostlaan/meteord:onbuild ./onbuild &&
docker build -t joostlaan/meteord:devbuild ./devbuild &&
docker build -t joostlaan/meteord:binbuild ./binbuild &&
docker build -t joostlaan/meteord:testbuild ./testbuild &&
docker build -t joostlaan/meteord:distbuild ./distbuild

docker push joostlaan/meteord:base &&
docker push joostlaan/meteord:onbuild &&
docker push joostlaan/meteord:devbuild &&
docker push joostlaan/meteord:binbuild &&
docker push joostlaan/meteord:testbuild &&
docker push joostlaan/meteord:distbuild





## MeteorD - Docker Runtime for Meteor Apps

There are two main ways you can use Docker with Meteor apps. They are:

1. Build a Docker image for your app
2. Running a Meteor bundle with Docker

**MeteorD supports these two ways. Let's see how to use MeteorD**

### 1. Build a Docker image for your app

With this method, your app will be converted into a Docker image. Then you can simply run that image.  

For that, you can use `joostlaan/meteord:onbuild` as your base image. Magically, that's only you've to do. Here's how to do it.

Add following `Dockerfile` into the root of your app:

~~~shell
FROM joostlaan/meteord:onbuild
~~~

Then you can build the docker image with:

~~~shell
docker build -t yourname/app .
~~~

Then you can run your meteor image with

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -p 8080:80 \
    yourname/app
~~~
Then you can access your app from the port 8080 of the host system.

#### Stop downloading Meteor each and every time (mostly in development)

So, with the above method, MeteorD will download and install Meteor each and every time. That's bad specially in development. So, we've a solution for that. Simply use `joostlaan/meteord:devbuild` as your base image.

> WARNING: Don't use `joostlaan/meteord:devbuild` for your final build. If you used it, your image will carry the Meteor distribution as well. As a result of that, you'll end up with an image with ~700 MB.

### 2. Running a Meteor bundle with Docker

For this you can directly use the MeteorD to run your meteor bundle. MeteorD can accept your bundle either from a local mount or from the web. Let's see:

#### 2.1 From a Local Mount

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -v /mybundle_dir:/bundle \
    -p 8080:80 \
    joostlaan/meteord:base
~~~

With this method, MeteorD looks for the tarball version of the meteor bundle. So, you should build the meteor bundle for `os.linux.x86_64` and put it inside the `/bundle` volume. This is how you can build a meteor bundle.

~~~shell
meteor build --architecture=os.linux.x86_64 ./
~~~

#### 2.1 From the Web

You can also simply give URL of the tarball with `BUNDLE_URL` environment variable. Then MeteorD will fetch the bundle and run it. This is how to do it:

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -e BUNDLE_URL=http://mybundle_url_at_s3.tar.gz \
    -p 8080:80 \
    joostlaan/meteord:base
~~~


#### Rebuilding Binary Modules

Sometimes, you need to rebuild binary npm modules. If so, expose `REBULD_NPM_MODULES` environment variable. It will take couple of seconds to complete the rebuilding process.

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -e BUNDLE_URL=http://mybundle_url_at_s3.tar.gz \
    -e REBULD_NPM_MODULES=1 \
    -p 8080:80 \
    joostlaan/meteord:binbuild
~~~

## Known Issues

#### Spiderable Not Wokring (But, have a fix)

There are some issues when running spiderable inside a Docker container. For that, check this issue: https://github.com/meteor/meteor/issues/2429

Fortunately, there is a fix. Simply use [`ongoworks:spiderable`](https://github.com/ongoworks/spiderable) instead the official package.

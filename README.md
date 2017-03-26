LtC Compiler
============

The compiler is based on a reduced set of the Arduino toolchain with a
simplified version of the Codebender compiler running on a PHP FastCGI
module.

It is API-compatible with Codebender.

Build the compiler container with:

    docker build \
          -t xobs/ltc-compiler-armhf:${tag} \
          .

Make sure you have a network created specifically for ltc, to allow DNS:

    docker network create ltc-net

Run the compiler with the following Docker arguments:

    docker run \
          -d \
          --name=ltc-compiler \
          --net=ltc-net \
          xobs/ltc-compiler-armhf:${tag}

To save build files, bind /tmp/cache/filebkp/ to a local path:

    docker run \
          -d \
          -v $(pwd)/filebkp:/var/cache/filebkp \
          --name=ltc-compiler \
          --net=ltc-net \
          xobs/ltc-compiler-armhf:${tag}

The compiler will now be listening on ltc-compiler:9000.


Using with UX
--------------

The ltc-ux image expects to be able to talk to this image over fastcgi.  It
references this image by name, and so it must be called "ltc-compiler" and be
located on the same network.

Network
-------

Containers refer to each other using their names.  Be sure to put everything on the same network:

    docker network create ltc-network


Compiler
--------

The compiler is based on a reduced set of the Arduino toolchain with a simplified version of the Codebender compiler running on a PHP FastCGI module.

Build the compiler container with:

    docker build -t xobs/ltc-compiler:1.11 compiler/

Run the compiler with the following Docker arguments:

    docker run -d --net=ltc-network --name ltc-compiler xobs/ltc-compiler:1.11

To save build files, bind /tmp/cache/filebkp/ to a local path:

    docker run -d --net=ltc-network -v $(pwd)/filebkp:/var/cache/filebkp --name ltc-compiler xobs/ltc-compiler:1.10

The compiler will now be listening on ltc-compiler:9000.


Using with UX
--------------

The ltc-ux image expects to be able to talk to this image over fastcgi.  It
references this image by name, and so it must be called "ltc-compiler" and be
located on the same network.
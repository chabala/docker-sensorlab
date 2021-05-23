docker-sensorlab
================

Docker image for LogIT SensorLab application.

SensorLab is a product of [LogIT World](http://logitworld.com/index.php/support/software-downloads-updates) for interacting with their data logger products. I made this docker image to isolate it from my system, initially because I didn't trust it, but as I found later, it also requires some older libraries to run.

I used it to update the firmware on my DataMeter 1000 over a serial link, which it can do without needing to be registered or licensed in any way.

Usage:

 * install docker (or an alternative you prefer)
 * install docker-compose (version 1.27.0 or better, the compose file is using the vendor neutral format)
 * clone the repo

    docker-compose up

All trademarks and/or copyrights are the property of their respective owners. This software is provided as is, with no warranty of any kind.


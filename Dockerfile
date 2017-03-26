FROM armhf/php:7.1-fpm

MAINTAINER Sean Cross <xobs@kosagi.com>

RUN apt-get update && \
    apt-get install -y \
        curl bzip2 unzip \
    && \
    mkdir -p /opt/codebender/ && \
    mkdir -p /var/cache/filebkp

# Download the Arduino IDE and start to prune it
RUN curl -sSL -o /arduino-1.6.13-linuxarm.tar.xz 'http://arduino.cc/download.php?f=/arduino-1.6.13-linuxarm.tar.xz' && \
    [ $(sha256sum /arduino-1.6.13-linuxarm.tar.xz | awk '{print $1}') = "36819d57f86d817605729a38f07702b187701e4415ab115dc659d5cc9c4691bc" ] && \
    curl -sSL -o /gcc-arm-none-eabi-4_8-2014q1-20160201-linux.tar.bz2 'https://github.com/PaulStoffregen/ARM_Toolchain_2014q1_Source/raw/master/pkg/gcc-arm-none-eabi-4_8-2014q1-20160201-linux.tar.bz2' && \
    [ $(sha256sum /gcc-arm-none-eabi-4_8-2014q1-20160201-linux.tar.bz2 | awk '{print $1}') = "ebe96b34c4f434667cab0187b881ed585e7c7eb990fe6b69be3c81ec7e11e845" ] && \
    mkdir -p /opt/codebender/codebender-arduino-core-files/v167/packages/arduino/tools/arm-none-eabi-gcc && \
    tar xvjf /gcc-arm-none-eabi-4_8-2014q1-20160201-linux.tar.bz2 -C /opt/codebender/codebender-arduino-core-files/v167/packages/arduino/tools/arm-none-eabi-gcc && \
    rm -f /gcc-arm-none-eabi-4_8-2014q1-20160201-linux.tar.bz2 && \
    mkdir /unpack && \
    tar xvJf /arduino-1.6.13-linuxarm.tar.xz -C /unpack && \
    rm -f /arduino-1.6.13-linuxarm.tar.xz && \
    true

RUN true && \
    mv /unpack/arduino-1.6.13/arduino-builder /opt/codebender/codebender-arduino-core-files/v167/ && \
    mv /unpack/arduino-1.6.13/tools-builder /opt/codebender/codebender-arduino-core-files/v167/ && \
    mkdir -p /opt/codebender/codebender-arduino-core-files/v167/hardware/chibitronics && \
    curl -sSL -o /opt/codebender/codebender-arduino-core-files/v167/hardware/platform.txt https://raw.githubusercontent.com/xobs/arduino-compiler/v167/v167/hardware/platform.txt && \
    true

RUN true && \
    curl -sSL -o /arduino-esplanade.zip 'https://github.com/xobs/arduino-esplanade/archive/master.zip' && \
    unzip /arduino-esplanade.zip -d /unpack && \
    rm -f /arduino-esplanade.zip && \
    mv /unpack/arduino-esplanade-master/hardware/* /opt/codebender/codebender-arduino-core-files/v167/hardware/chibitronics && \
    rm -rf /unpack && \
    true

COPY app.php /

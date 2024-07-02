FROM cirrusci/flutter:stable

USER root
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    clang \
    libgtk-3-dev \
    x11-apps

RUN useradd -ms /bin/bash developer
RUN mkdir -p /app && chown developer:developer /app
RUN chown -R developer:developer /sdks/flutter
RUN mkdir -p /home/developer/.pub-cache && chown -R developer:developer /home/developer/.pub-cache

RUN chown -R developer:developer /opt/android-sdk-linux

USER developer
WORKDIR /app

RUN git config --global --add safe.directory /sdks/flutter

ENV DISPLAY=:0

CMD ["sh", "-c", "flutter pub get && flutter run --release"]
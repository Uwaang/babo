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

USER developer
WORKDIR /app

RUN git config --global --add safe.directory /sdks/flutter

ENV DISPLAY=:0

CMD ["sh", "-c", "if [ ! -f pubspec.yaml ]; then flutter create . && flutter pub get; fi && flutter run --release"]
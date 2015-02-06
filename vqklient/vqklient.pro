TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp
 CONFIG+=qml_debug
DEFINES += QMLJSDEBUGGER
RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
IMPORTPATH += $$PWD/../qml-material/modules \
              $$PWD/../qml-extras/modules
QML_IMPORT_PATH += $$PWD/../qml-material/modules \
                   $$PWD/../qml-extras/modules

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

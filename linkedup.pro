# Add more folders to ship with the application, here
folder_01.source = qml/linkedup
folder_01.target = qml
folder_lib.source = lib/
folder_lib.target = ./
launcher.source = ./linkedup.sh
launcher.target = ./
DEPLOYMENTFOLDERS = folder_01\
					folder_lib\	#for deploying
					launcher	#for deploying

#LIBS += -L/usr/lib -loauth
LIBS += -L./lib/ -loauth		#for deploying
#LIBS += -L/usr/local/lib -loauth
QT += declarative\
		xml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE1DC77D4

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    authorizer.cpp \
    linkedinapi.cpp \
    sharemodel.cpp \
    user.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    authorizer.h \
    settings.h \
    linkedinapi.h \
    creds.h \
    sharemodel.h \
    user.h \
    notifier.h

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    status.xml \
    TODO.txt \
    changes.txt

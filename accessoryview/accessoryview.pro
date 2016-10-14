QT += core gui

include($$PWD/../qtcontent/qtcontent.pri)

QMAKE_OBJCXXFLAGS += -fobjc-arc
OBJECTIVE_SOURCES += main.mm
LIBS += -framework AppKit

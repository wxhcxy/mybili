cmake_minimum_required(VERSION 3.16)

project(mybili VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)#添加资源文件res.qrc

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appmybili
    main.cpp
)

qt_add_qml_module(appmybili
    URI mybili
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES LeftSideBar.qml
    RESOURCES res.qrc
    QML_FILES HeadToolBar.qml
    QML_FILES RecommendPage.qml
    SOURCES networkhttp.h networkhttp.cpp
    SOURCES videodata.h videodata.cpp
    SOURCES videomodel.h videomodel.cpp
    QML_FILES PlayVideoWindow.qml
    QML_FILES VideoProcessSlider.qml
    QML_FILES VideoDelegate.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appmybili PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appmybili
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appmybili
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appmybili
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

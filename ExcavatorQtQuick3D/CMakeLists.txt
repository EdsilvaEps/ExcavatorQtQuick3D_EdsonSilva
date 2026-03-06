cmake_minimum_required(VERSION 3.16)

project(ExcavatorQtQuick3D VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appExcavatorQtQuick3D
    main.cpp
)

qt_add_qml_module(appExcavatorQtQuick3D
    URI ExcavatorQtQuick3D
    QML_FILES
        Main.qml
)

add_subdirectory(modules/MyModule/)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appExcavatorQtQuick3D PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appExcavatorQtQuick3D
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appExcavatorQtQuick3D
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
        MyModulelibplugin
)

include(GNUInstallDirs)
install(TARGETS appExcavatorQtQuick3D
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

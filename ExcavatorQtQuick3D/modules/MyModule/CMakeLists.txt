project(MyModule VERSION 0.1 LANGUAGES CXX)

qt_add_qml_module(${PROJECT_NAME}lib
    STATIC
    URI MyModule
    QML_FILES
        Joystick.qml
        Excavator.qml
    RESOURCES
        meshes/aset_nature_rock_M_venodhb_LOD0.mesh
        meshes/arm_link_mesh.mesh
        meshes/boom_cylinder_mesh.mesh
        meshes/bucket_cylinder_mesh.mesh
        meshes/bucket_link_mesh.mesh
        meshes/cab_mesh.mesh
        meshes/mesh_001_mesh.mesh
        meshes/mesh_002_mesh.mesh
        meshes/mesh_004_mesh.mesh
        meshes/mesh_007_mesh.mesh
        meshes/mesh_010_mesh.mesh
        meshes/mesh_011_mesh.mesh
        meshes/mesh_012_mesh.mesh
        meshes/mesh_mesh.mesh
        textures/venodhb_2K_Albedo.jpg
        textures/venodhb_2K_Normal_LOD0.jpg
        textures/venodhb_2K_Roughness.jpg

    SOURCES
        backend.h
        backend.cpp
        QML_FILES DesertTerrain.qml
)

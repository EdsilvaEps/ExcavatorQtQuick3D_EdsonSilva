import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    Texture {
        id: snow_02_diff_1k_jpg_texture
        objectName: "snow_02_diff_1k.jpg"
        source: "textures/snow_02_diff_1k.jpg"
    }
    PrincipledMaterial {
        id: rock_face_03_material
        objectName: "rock_face_03"
        baseColorMap: snow_02_diff_1k_jpg_texture
    }

    // Nodes:
    Node {
        id: scene
        objectName: "Scene"
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        Model {
            id: terrain
            objectName: "terrain"
            rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
            scale: Qt.vector3d(0.474782, 0.474782, 0.474782)
            source: "meshes/terrain_mesh.mesh"
            materials: [
                rock_face_03_material
            ]
        }
        /*PerspectiveCamera {
            id: camera_camera
            objectName: "Camera"
            position: Qt.vector3d(7.35889, -6.92579, 4.95831)
            rotation: Qt.quaternion(0.780483, 0.483536, 0.208704, 0.336872)
            scale: Qt.vector3d(1, 1, 1)
            clipNear: 0.10000000149011612
            clipFar: 100
            fieldOfView: 39.59775161743164
            fieldOfViewOrientation: PerspectiveCamera.Horizontal
        }
        PointLight {
            id: light_light
            objectName: "Light"
            position: Qt.vector3d(4.07624, 1.00545, 5.90386)
            rotation: Qt.quaternion(0.570948, 0.169076, 0.272171, 0.75588)
            scale: Qt.vector3d(1, 1, 1)
            brightness: 1000
            quadraticFade: 0
        }*/
    }

    // Animations:
}

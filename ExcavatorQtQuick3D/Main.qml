import QtQuick
import QtQuick3D
import QtQuick.Controls
import QtQuick3D.Helpers
import QtQuick3D.AssetUtils
import MyModule

Window {
    width: 640
    height: 480
    visible: true
    color: "black"

    View3D {
        anchors.fill: parent

        environment: ExtendedSceneEnvironment {
            backgroundMode: SceneEnvironment.SkyBox
            lightProbe: Texture {
                textureData: ProceduralSkyTextureData { }
            }
            ditheringEnabled: true
            /*InfiniteGrid {
                gridInterval: 100
            }*/
        }


        DesertTerrain {
            id: desertGround

            scale.x: 100
            scale.y: 10
            scale.z: 100

        }

        Node {
            id: sceneRoot
            eulerRotation.x: -7
            eulerRotation.y: -76
            position.x: 59
            position.y: -42
            position.z: 40
            PerspectiveCamera {
                id: cameraNode
                z: 500
                x: -35
                y: 70
            }
        }

        // movable camera
        OrbitCameraController {
            origin: sceneRoot
            camera: cameraNode

        }

        DirectionalLight { }

        Node {
                id: modelNode
                //eulerRotation.y: 60

                Excavator {
                    id: excavator
                    scale: Qt.vector3d(30, 30, 30)
                    armRotation: backend.armRotation
                    bucketRotation: backend.bucketRotation
                    cockpitRotation: backend.trackRotation

                    // calculate where the tracks are pointing to
                    function forwardVector(){
                        let yaw = backend.trackRotation * (Math.PI / 180) // yaw converted to radians
                        return Qt.vector3d(-Math.sin(yaw), 0, -Math.cos(yaw)) // front facing vector
                    }

                    function moveForward(speed) {
                        let f = forwardVector()
                        position.x += f.x * speed // new position = old positon + direction * speed
                        position.z += f.z * speed
                        console.log("angular motion: x: " , f.x , " | y: ", f.y, "| z: ", f.z)

                    }

                    function moveBackward(speed) {
                        let f = forwardVector()
                        position.x -= f.x * speed
                        position.z -= f.z * speed
                    }

                    onPositionChanged:{
                        console.log("Absolute position of excavator: ",
                                    excavator.position.x, "| posY ",
                                    excavator.position.y, "| posZ ",
                                    excavator.position.z);
                    }


                }
        }

    }

    Joystick {
        id: movementStick
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        upLabel: "Forward"
        downLabel: "Reverse"
        leftLabel: "Turn L"
        rightLabel: "Turn R"

    }

    Joystick {
        id: boomStick
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        upLabel: "Lift"
        downLabel: "Lower"
        leftLabel: "Open"
        rightLabel: "Close"
    }

    Backend{
        id:backend
    }

    /*
    Timer to ensure the rotations will continue for as long
    as the user maintains the knob in the specified direction

    Timer can be replaced with FrameAnimation, since it runs in synchronization with the frame update in the animation,
    it, runs the handler every time there's a change in frames, it'd make animations smoother
    */
    Timer {
        id: boomStickTimer
        interval: 16 // ~60 FPS
        repeat: true
        running: boomStick.command !== "None"

        onTriggered: {
            if (boomStick.command === "Lift") {
                backend.moveArm(+0.5)
            } else if (boomStick.command === "Lower") {
                backend.moveArm(-0.5)
            } else if (boomStick.command === "Open") {
                backend.moveBucket(+1.5)
            } else if (boomStick.command === "Close") {
                backend.moveBucket(-1.5)
            }
        }
    }

    Timer {
        id: movementStickTimer
        interval: 16
        repeat: true
        running: movementStick.command !== "None"

        onTriggered: {
            if (movementStick.command === "Turn L") {
                backend.setTrackRotation(+0.5)
            } else if (movementStick.command === "Turn R") {
                backend.setTrackRotation(-0.5)
            } else if (movementStick.command === "Forward") {
                excavator.moveForward(1.5)
            } else if (movementStick.command === "Reverse") {
                excavator.moveBackward(1.5)
            }
        }
    }

}

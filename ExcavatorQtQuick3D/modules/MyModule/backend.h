#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QQmlEngine>
#include <QtMath>

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    // exposes rotationX and rotationY to QML - READ rotation[XY] are getters
    // NOTIFY rotationChanged is our emitted signal for changes
    Q_PROPERTY(float armRotation READ armRotation NOTIFY armRotationChanged FINAL)
    Q_PROPERTY(float bucketRotation READ bucketRotation NOTIFY bucketRotationChanged FINAL)
    Q_PROPERTY(float trackRotation READ trackRotation WRITE setTrackRotation NOTIFY trackRotationChanged FINAL)

public:
    explicit Backend(QObject *parent = nullptr);

    float armRotation() const { return m_armRotation; }
    float bucketRotation() const { return m_bucketRotation; }
    float trackRotation() const;

    Q_INVOKABLE void moveArm(float amount);
    Q_INVOKABLE void moveBucket(float amount);
    Q_INVOKABLE void setTrackRotation(float amount);

private:
    float m_bucketRotation = 0;
    float m_bucketRotationLimits[2] = {-130.0f, 60.0f};

    float m_armRotation = 0;
    float m_armRotationLimits[2] = {-5.0f, 30.0f};

    float m_trackRotation = 0;
    float m_trackRotationLimits[2] = {-180.0f, 180.0f};

signals:
    void armRotationChanged();
    void bucketRotationChanged();
    void trackRotationChanged();
};

#endif // BACKEND_H

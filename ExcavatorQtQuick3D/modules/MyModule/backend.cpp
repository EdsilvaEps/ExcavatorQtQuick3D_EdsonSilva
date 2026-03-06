#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject{parent}
{}

void Backend::moveArm(float amount)
{
    m_armRotation += amount;
    m_armRotation = qBound(m_armRotationLimits[0], m_armRotation, m_armRotationLimits[1]);
    qInfo() << "Arm rotation values: " << m_armRotation ;
    emit armRotationChanged();

}

void Backend::moveBucket(float amount)
{
    m_bucketRotation += amount;
    if(m_bucketRotation > m_bucketRotationLimits[1]) m_bucketRotation = m_bucketRotationLimits[1];
    if(m_bucketRotation < m_bucketRotationLimits[0]) m_bucketRotation = m_bucketRotationLimits[0];

    qInfo() << "bucket rotation values: " << m_bucketRotation ;

    emit bucketRotationChanged();

}

float Backend::trackRotation() const
{
    return m_trackRotation;
}

void Backend::setTrackRotation(float amount)
{

    m_trackRotation += amount;

    if(m_trackRotation > m_trackRotationLimits[1]) m_trackRotation = m_trackRotationLimits[1];
    if(m_trackRotation < m_trackRotationLimits[0]) m_trackRotation = m_trackRotationLimits[0];
    qInfo() << "track rotation values: " << m_trackRotation ;
    emit trackRotationChanged();
}

Backend::TerrainType Backend::terrain() const
{
    return m_terrain;
}

void Backend::setTerrain(TerrainType newTerrain)
{
    qInfo() << "New terrain selected: " << newTerrain ;
    if (m_terrain == newTerrain)
        return;
    m_terrain = newTerrain;
    emit terrainChanged();
}

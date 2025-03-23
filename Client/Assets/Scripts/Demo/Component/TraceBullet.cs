using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEngine.GraphicsBuffer;

public class TraceBullet : BulletBase
{
    public float traceTime = 0.5f;
    private Vector3 lastDirection = Vector3.zero;
    public override void UpdateBehaviour()
    {
        if (target == null || target.transform == null)
        {
            Destroy(gameObject);
            return;
        }

        if (traceTime > 0)
        {
            Vector3 direction = target.transform.position - transform.position;
            lastDirection = direction.normalized;
            traceTime -= GameMain.deltaTime;
        }

        transform.position += lastDirection * speed * GameMain.deltaTime;

        lifetime -= GameMain.deltaTime;
        if (lifetime <= 0)
        {
            Destroy(gameObject);
        }
    }
}

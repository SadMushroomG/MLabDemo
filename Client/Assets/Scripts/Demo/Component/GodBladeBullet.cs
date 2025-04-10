using UnityEngine;

public class GodBladeBullet : BulletBase
{

    public override void Initialize(GameObject target, float spd, float dmg, MLabActorType actorType, WeaponBase weapon)
    {
        base.Initialize(target, spd, dmg, actorType, weapon);
    }

    public override void UpdateBehaviour()
    {
        // 按照固定方向移动
        transform.position += velocity * GameMain.deltaTime;

        // 检查生命周期
        lifetime -= GameMain.deltaTime;
        if (lifetime <= 0)
        {
            Destroy(gameObject);
        }
    }

    public override void OnBulletHit(Collider2D other)
    {
        base.OnBulletHit(other);
    }
} 
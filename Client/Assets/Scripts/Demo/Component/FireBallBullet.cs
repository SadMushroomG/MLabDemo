using UnityEngine;

public class FireBallBullet : BulletBase
{
    private Vector3 moveDirection;

    public override void Initialize(GameObject target, float spd, float dmg, MLabActorType actorType, WeaponBase weapon)
    {
        base.Initialize(target, spd, dmg, actorType, weapon);
        // 计算初始方向并保存
        moveDirection = (target.transform.position - transform.position).normalized;
    }

    public override void UpdateBehaviour()
    {
        // 按照固定方向移动
        transform.position += moveDirection * speed * GameMain.deltaTime;

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
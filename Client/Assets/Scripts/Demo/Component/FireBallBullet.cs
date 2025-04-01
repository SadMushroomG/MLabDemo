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
        // 检查是否击中目标
        var actor = other.GetComponent<ActorBase>();
        if (actor != null && actor.actorType == targetType)
        {
            // 造成伤害
            actor.TakeDamage(bulletDamage);
            actor.SetLastAttackedActor(GetComponentInParent<WeaponBase>()?.GetOwner());
            JumpWordHelper.Instance.GenerateJumpWord(actorType, bulletDamage.ToString(), actor.transform.position + Vector3.up * 0.5f);
            
            // 通知武器子弹击中
            if (Weapon.OnBulletHit(this))
            {
                Destroy(gameObject);
            }
        }
    }
} 
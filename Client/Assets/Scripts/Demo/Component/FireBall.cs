using UnityEngine;

public class FireBall : WeaponBase
{
    [Header("火球属性")]
    public float fireBallScale = 1.5f;
    
    public float explosionRadius = 3f;

    protected override void SpawnAttackEffect(GameObject target)
    {
        if (attackEffectPrefab != null)
        {
            GameObject effect = Instantiate(attackEffectPrefab, transform.position, Quaternion.identity);
            effect.transform.parent = GameMain.GetBulletRoot();
            effect.transform.localScale = Vector3.one * fireBallScale;
            
            BulletBase bullet = effect.GetComponent<BulletBase>();
            bullet.Initialize(target, bulletSpeed, damage + DamageAdd, owner.actorType, this);
            bulletList.Add(bullet);
        }
    }

    protected override bool CheckAndAttack(float distanceToTarget)
    {
        isInAttackRange = distanceToTarget <= attackRange;

        if (Input.GetKeyDown (KeyCode.Space) && isInAttackRange && (GameMain.globalTime - lastAttackTime) >= (attackCooldown / AttackCooldownMultiParam))
        {
            Attack();
            lastAttackTime = GameMain.globalTime;
            return true;
        }
        return false;
    }

    public override bool OnBulletHit(BulletBase bullet)
    {
        return false;
    }
} 
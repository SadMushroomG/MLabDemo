using UnityEngine;

public class GodBladeWeapon : WeaponBase
{
    public int bladeCount = 3;
    public float explosionRadius = 3f;
    public float generateRadius = 3f;

    private static Vector3 MoveDir = new Vector3(0.707f, 0.707f, 0);
    protected override void SpawnAttackEffect(GameObject target)
    {
        if (attackEffectPrefab != null)
        {
            for (int i = 0; i < bladeCount; i++)
            {
                var actorPos = ActorManager.Instance.GetRandomRedActorPosition();
                var startPos = MoveDir * bulletSpeed + actorPos;

                GameObject effect = Instantiate(attackEffectPrefab, startPos, Quaternion.identity);
                effect.transform.parent = GameMain.GetBulletRoot();
                effect.transform.localScale = Vector3.one;

                BulletBase bullet = effect.GetComponent<BulletBase>();
                bullet.Initialize(target, bulletSpeed, damage + DamageAdd, owner.actorType, this);
                bulletList.Add(bullet);
                bullet.velocity = -MoveDir * bulletSpeed;
            }
        }
    }
    protected override bool CheckAndAttack(float distanceToTarget)
    {
        if (Input.GetKeyDown (KeyCode.Space) && (GameMain.globalTime - lastAttackTime) >= (attackCooldown / AttackCooldownMultiParam))
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
using UnityEngine;

public class GodBladeWeapon : WeaponBase
{
    public int bladeCount = 3;
    public float fireBallScale = 1.5f;
    
    public float explosionRadius = 3f;
    public float generateRadius = 3f;

    protected override void SpawnAttackEffect(GameObject target)
    {
        if (attackEffectPrefab != null)
        {
            for (int i = 0; i < bladeCount; i++)
            {
                var offsetX = Random.Range(-1,6);
                var offsetY = Random.Range(5, 10);
                var pos = new Vector3(offsetX, 5, transform.position.z);

                GameObject effect = Instantiate(attackEffectPrefab, pos, Quaternion.identity);
                effect.transform.parent = GameMain.GetBulletRoot();
                effect.transform.localScale = Vector3.one * fireBallScale;

                BulletBase bullet = effect.GetComponent<BulletBase>();
                bullet.Initialize(target, bulletSpeed, damage + DamageAdd, owner.actorType, this);
                bulletList.Add(bullet);
                bullet.velocity = Vector3.down * bulletSpeed;
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
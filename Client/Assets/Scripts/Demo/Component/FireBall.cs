using System.Collections.Generic;
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

    protected override void FindNearestTarget()
    {
        if (!CheckCanAttack())
        {
            return;
        }
        //已经有目标了，并且没死，就继续打着
        if (target != null)
        {
            return;
        }
        // 获取目标类型
        MLabActorType targetType = GameMain.Instance.GetTargeType(owner.actorType);
        if (targetType == MLabActorType.None) return;

        target = null;
        if (targetType == MLabActorType.SpwanA)
        {
            target = GameMain.Instance.redSpawn.gameObject;
        }
        else if (targetType == MLabActorType.SpwanB)
        {
            target = GameMain.Instance.blueSpawn.gameObject;
        }
        else
        {
            // 获取所有可能的目标
            var targetList = new List<GameObject>();
            if (owner.actorType == MLabActorType.SpwanB)
                targetList = ActorManager.Instance.redActorList;
            else
                targetList = ActorManager.Instance.blueActorList;

            if (targetList == null || targetList.Count == 0)
            {
                target = null;
                return;
            }

            //var nearestActor = targetList[0];
            //var minDistance = Vector2.Distance(transform.position, nearestActor.transform.position);
            Vector3 dir = Vector3.zero;
            var nearestActor = targetList[0];
            float nearestAngle = float.MaxValue;
            foreach (var actor in targetList)
            {
                dir += (actor.transform.position - transform.position).normalized;
            }
            dir = dir.normalized;
            foreach (var actor in targetList)
            {
                float angle = Vector3.Dot( (actor.transform.position - transform.position).normalized, dir );
                if (angle < nearestAngle)
                {
                    nearestActor = actor;
                }
            }
            target = nearestActor;
        }
    }

    //有时候计算消耗太高，先提前判断下需不需要计算
    private bool CheckCanAttack()
    {
        if ((GameMain.globalTime - lastAttackTime) >= (attackCooldown / AttackCooldownMultiParam))
        {
            return true;
        }
        return false;
    }

    protected override bool CheckAndAttack(float distanceToTarget)
    {
        isInAttackRange = distanceToTarget <= attackRange;

        if (isInAttackRange && (GameMain.globalTime - lastAttackTime) >= (attackCooldown / AttackCooldownMultiParam))
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
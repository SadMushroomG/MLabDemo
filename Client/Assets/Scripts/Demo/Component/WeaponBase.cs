using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeaponBase : MonoBehaviour
{
    [Header("攻击属性")]
    public float damage = 10f;
    public float attackRange = 2f;
    public float attackCooldown = 1f;
    public float bulletSpeed = 1f;

    [Header("特效")]
    public GameObject attackEffectPrefab;
    public float effectDuration = 0.5f;

    protected ActorBase owner;
    public GameObject target;
    public MLabActorType targetType;
    public bool attacked = false;

    //攻击检测
    [TitleGroup("攻击检测")]
    [LabelText("检测范围")]
    public float detectionRadius = 10f;

    [TitleGroup("攻击检测")]
    [LabelText("检测更新间隔")]
    public float targetUpdateInterval = 0.5f;

    private float lastUpdateTime;
    private float lastAttackTime;

    protected bool isInAttackRange;

    //发射出去的东西
    private List<BulletBase> bulletList = new List<BulletBase>();

    public void Awake()
    {

    }

    private void OnDrawGizmos()
    {
        // 显示检测范围
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(transform.position, detectionRadius);

        // 显示攻击范围
        Gizmos.color = new Color(1f, 0f, 0f, 0.3f);
        Gizmos.DrawWireSphere(transform.position, attackRange);

        // 如果有目标，显示连线
        if (target != null)
        {
            Gizmos.color = Color.red;
            Gizmos.DrawLine(transform.position, target.transform.position);
        }
    }

    public void SetOwner(ActorBase actor)
    {
        owner = actor;
    }

    public ActorBase GetOwner()
    {
        return owner;
    }

    public void SetTarget(GameObject target)
    {
        this.target = target;
    }

    protected virtual void SpawnAttackEffect(GameObject target)
    {
        if (attackEffectPrefab != null)
        {
            GameObject effect = Instantiate(attackEffectPrefab, transform.position, Quaternion.identity);
            effect.transform.parent = GameMain.GetBulletRoot();
            //effect.transform.LookAt(target.transform.position);
            BulletBase bullet = effect.GetComponent<BulletBase>();
            bullet.Initialize(target, bulletSpeed, damage, owner.actorType, this);
            bulletList.Add(bullet);
            //Destroy(effect, effectDuration);
        }
    }

    public void OnBulletHit(BulletBase bullet)
    {
        bulletList.Remove(bullet);
    }

    public virtual void Attack()
    {
        if (target == null)
        {
            return;
        }
        SpawnAttackEffect(target);

        /*
        // 检测目标
        Collider[] colliders = Physics.OverlapSphere(targetPos, attackRange);
        foreach (Collider col in colliders)
        {
            ActorBase targetActor = col.GetComponent<ActorBase>();
            if (targetActor != null && targetActor.actorType != attackerType)
            {
                targetActor.TakeDamage(damage);
                attacker.SetLastAttackedActor(targetActor);
            }
        }
        */
    }

    private void Update()
    {
        // 定期更新目标
        if ((GameMain.globalTime - lastUpdateTime) >= targetUpdateInterval || target == null)
        {
            FindNearestTarget();
            lastUpdateTime = GameMain.globalTime;
        }

        // 如果有目标，检查是否可以攻击
        if (target != null)
        {
            float distanceToTarget = Vector2.Distance(transform.position, target.transform.position);
            attacked = CheckAndAttack(distanceToTarget);
        }
    }

    protected bool CheckAndAttack(float distanceToTarget)
    {
        isInAttackRange = distanceToTarget <= attackRange;

        if (isInAttackRange && (GameMain.globalTime - lastAttackTime) >= attackCooldown)
        {
            Attack();
            lastAttackTime = GameMain.globalTime;
            return true;
        }
        return false;
    }


    private void FindNearestTarget()
    {
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

            var nearestActor = targetList[0];
            var minDistance = Vector2.Distance(transform.position, nearestActor.transform.position);
            foreach (var actor in targetList)
            {
                var distance = Vector2.Distance(transform.position, actor.transform.position);
                if (distance < minDistance)
                {
                    minDistance = distance;
                    nearestActor = actor;
                }
            }
            target = nearestActor;
        }

        if (target != null)
        {
            Debug.Log($"{transform.parent.name} FindNearestTarget {target.name}");
        }
        else
        {
            Debug.Log($"{transform.parent.name} FindNearestTarget is NULL!!!!");
        }
        //GameObject[] potentialTargets = GameObject.FindGameObjectsWithTag(targetType.ToString());
        //float nearestDistance = float.MaxValue;
        //Transform nearestTarget = null;

        //foreach (GameObject target in potentialTargets)
        //{
        //    if (target == null || !target.activeInHierarchy) continue;

        //    float distance = Vector2.Distance(transform.position, target.transform.position);
        //    if (distance < detectionRadius && distance < nearestDistance)
        //    {
        //        // 验证目标类型
        //        ActorBase targetActor = target.GetComponent<ActorBase>();
        //        if (targetActor != null && targetActor.actorType == targetType)
        //        {
        //            nearestDistance = distance;
        //            nearestTarget = target.transform;
        //        }
        //    }
        //}
    }
}

using UnityEngine;
using System.Collections.Generic;

public class XiaoBingBuff : WeaponBase
{
    [Header("增益属性")]
    public float buffInterval = 10f;
    
    public float attackBonus = 10f;

    private float lastBuffTime;

    public override void Attack()
    {
        // 不需要普通攻击功能
    }
    protected override void SpawnAttackEffect(GameObject target)
    {
        if (attackEffectPrefab != null)
        { 
            GameObject effect = Instantiate(attackEffectPrefab, transform.position, Quaternion.identity);
            effect.transform.parent = GameMain.GetBulletRoot();
            effect.transform.localScale = Vector3.one;
            effect.gameObject.SetActive(true);
        }
    }

    protected override bool CheckAndAttack(float distanceToTarget)
    {
        // 不需要检查攻击距离
        return false;
    }

    protected void Update()
    {
        // 检查是否到达buff时间
        if (GameMain.globalTime - lastBuffTime >= buffInterval)
        {
            ApplyBuffToAllSoldiers();
            lastBuffTime = GameMain.globalTime;
            SpawnAttackEffect(null);
        }
    }

    public override float GetColdDownProgress()
    {
        return Mathf.Clamp01((GameMain.globalTime - lastBuffTime) / (attackCooldown / AttackCooldownMultiParam));
    }

    private void ApplyBuffToAllSoldiers()
    {
        List<GameObject> targetList;
        
        // 根据所属阵营选择要buff的小兵列表
        if (owner.actorType == MLabActorType.SpwanB)
        {
            targetList = ActorManager.Instance.blueActorList;
        }
        else
        {
            targetList = ActorManager.Instance.redActorList;
        }

        // 为所有小兵的武器增加攻击力
        foreach (var soldier in targetList)
        {
            if (soldier != null)
            {
                // 获取小兵身上的所有武器
                var weapons = soldier.GetComponentsInChildren<WeaponBase>();
                foreach (var weapon in weapons)
                {
                    if (weapon != null)
                    {
                        // 增加武器攻击力
                        weapon.damage += attackBonus;
                        
                        // 创建buff特效（如果有的话）
                        if (attackEffectPrefab != null)
                        {
                            GameObject effect = Instantiate(attackEffectPrefab, weapon.transform.position, Quaternion.identity);
                            effect.transform.parent = weapon.transform;
                            Destroy(effect, effectDuration);
                        }
                    }
                }
                GameObject buffShow = soldier.transform.Find("anim_root/character/AttackBuff").gameObject;
                if (buffShow != null)
                {
                    buffShow.SetActive(true);
                }
            }
        }
    }
} 
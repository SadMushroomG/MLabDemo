using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeroWeapon : WeaponBase
{
    // Start is called before the first frame update
    void Start()
    {

    }

    public override void UpdateAttackBehavior()
    {
        // 定期更新目标
        if ((GameMain.globalTime - lastUpdateTime) >= targetUpdateInterval)
        {
            Vector2 targetPos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            SpawnAttackEffect(targetPos);
            lastUpdateTime = GameMain.globalTime;
        }
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SubCharacter : ActorBase
{
    public enum SubCharacterState
    {
        Moving,
        Idle,
    }
    public SubCharacterState curState;
    public Vector3 targetLocalPosition;

    public float moveSpeed = 1.0f;
    public float idleDeltaTime = 1.0f;

    private float deltaTime;

    public override void Awake()
    {
        curState = SubCharacterState.Idle;
        deltaTime = idleDeltaTime;
    }

    public void Update()
    {
        if (curState == SubCharacterState.Moving)
        {
            // 向目标位置移动
            Vector3 direction = (targetLocalPosition - transform.localPosition).normalized;
            transform.localPosition += direction * moveSpeed * Time.deltaTime;

            // 检查是否到达目标位置（使用一个小的阈值）
            if (Vector3.Distance(transform.localPosition, targetLocalPosition) < 0.1f)
            {
                curState = SubCharacterState.Idle;
                deltaTime = idleDeltaTime;
            }
        }
        else if (curState == SubCharacterState.Idle)
        {
            // 更新计时器
            deltaTime -= Time.deltaTime;

            // 计时结束后，选择新的随机位置并恢复Moving状态
            if (deltaTime <= 0)
            {
                curState = SubCharacterState.Moving;
                // 在这里设置新的随机目标位置
                targetLocalPosition = GetRandomPosition();
            }
        }
    }

    private Vector3 GetRandomPosition()
    {
        // 在圆形区域内获取随机位置
        float randomAngle = Random.Range(0f, 360f);
        float randomRadius = Random.Range(GameMain.Instance.blueSpawn.recycleCircleRadius * 0.8f, GameMain.Instance.blueSpawn.recycleCircleRadius);
        float x = randomRadius * Mathf.Cos(randomAngle * Mathf.Deg2Rad);
        float y = randomRadius * Mathf.Sin(randomAngle * Mathf.Deg2Rad);
        return new Vector3(x, y, transform.localPosition.z);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingBase : ActorBase
{
    public float recycleCircleRadius = 5f;

    public override void Awake()
    {
        base.Awake();
        EnsureComponents();
    }

    private void EnsureComponents()
    {
        // 添加 Rigidbody2D
        Rigidbody2D rb = GetComponent<Rigidbody2D>();
        if (rb == null)
        {
            rb = gameObject.AddComponent<Rigidbody2D>();
        }
        rb.isKinematic = true; // 设置为运动学，不受物理影响
        rb.gravityScale = 0f;

        // 添加 Collider2D
        Collider2D collider = GetComponent<Collider2D>();
        if (collider == null)
        {
            BoxCollider2D boxCollider = gameObject.AddComponent<BoxCollider2D>();
            boxCollider.isTrigger = true;
        }
        else
        {
            collider.isTrigger = true;
        }
    }

    private void Update()
    {
        // 检查游戏结束条件
        if (currentHealth <= 0)
        {
            GameMain.Instance.CheckGameOver();
        }
    }

    public void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, recycleCircleRadius);
    }
}

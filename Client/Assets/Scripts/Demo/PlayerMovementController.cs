using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovementController : MonoBehaviour
{
    public enum MovementAreaType
    {
        Rectangle,
        Circle,
    }

    [LabelText("移动区域类型")]
    public MovementAreaType movementAreaType = MovementAreaType.Circle;

    public Vector2 circleCenter = Vector2.zero;
    public float circleRadius = 5f;

    public float moveSpeed = 5f; // 移动速度
    public Vector2 moveRangeX = new Vector2(-8, 8); // 移动范围X    
    public Vector2 moveRangeY = new Vector2(-5, 5); // 移动范围X


    public GameObject character1;
    private Vector3 character1TargetPos;


    public GameObject character2;
    private Vector3 character2TargetPos;

    void Update()
    {
        // 获取WASD按键输入
        float moveX = Input.GetAxis("Horizontal"); // A/D 或 左/右箭头
        float moveY = Input.GetAxis("Vertical");   // W/S 或 上/下箭头

        // 计算移动方向
        Vector2 movement = new Vector2(moveX, moveY);

        // 归一化移动向量以防止斜向移动速度过快
        movement = movement * moveSpeed * GameMain.deltaTime;
        

        if (movementAreaType == MovementAreaType.Rectangle)
        {
            movement.x = Mathf.Clamp(movement.x, moveRangeX.x - transform.position.x, moveRangeX.y - transform.position.x);
            movement.y = Mathf.Clamp(movement.y, moveRangeY.x - transform.position.y, moveRangeY.y - transform.position.y);
        }
        else if (movementAreaType == MovementAreaType.Circle)
        { 
            var targetPos = new Vector2(transform.position.x + movement.x, transform.position.y + movement.y);
            var radius = targetPos - circleCenter;
            
            // 如果目标位置超出圆形范围，则将位置限制在圆上
            if (radius.magnitude > circleRadius)
            {
                radius = radius.normalized * circleRadius;
                targetPos = circleCenter + radius;
                movement = targetPos - new Vector2(transform.position.x, transform.position.y);
            }
        }

        // 移动角色
        transform.Translate(movement);
    }
}

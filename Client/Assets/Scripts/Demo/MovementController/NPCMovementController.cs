using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPCMovementController : MonoBehaviour
{
    [LabelText("移动速度")]
    public float speed = 5f;

    public float areaWidth = 16f;
    public float areaHeight = 10f;

    private Vector3 targetPosition;
    public float changeTargetInterval = 2f; // 每隔2秒更换一次目标位置
    private float timer;

    public GameObject blueSpawn; // 参考点
    public float minDistance = 5f; // 最小距离

    void Start()
    {
        blueSpawn = GameMain.Instance.blueSpawn.gameObject;
        SetRandomTargetPosition();
    }

    // Update is called once per frame
    void Update()
    {
        timer += Time.deltaTime;
        if (timer >= changeTargetInterval || Vector3.Distance(transform.position, blueSpawn.transform.position) < minDistance)
        {
            SetRandomTargetPosition();
            timer = 0f;
        }

        MoveTowardsTarget();
    }

    void SetRandomTargetPosition()
    {
        float randomX, randomY;
        Vector3 potentialPosition;

        do
        {
            randomX = Random.Range(-areaWidth / 2, areaWidth / 2);
            randomY = Random.Range(-areaHeight / 2, areaHeight / 2);
            potentialPosition = new Vector3(randomX, randomY, transform.position.z);
        } while (Vector3.Distance(potentialPosition, blueSpawn.transform.position) < minDistance);

        targetPosition = potentialPosition;
    }

    void MoveTowardsTarget()
    {
        transform.position = Vector3.MoveTowards(transform.position, targetPosition, speed * Time.deltaTime);
    }
}

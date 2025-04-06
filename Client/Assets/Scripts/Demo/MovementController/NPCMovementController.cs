using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPCMovementController : MonoBehaviour
{
    [LabelText("�ƶ��ٶ�")]
    public float speed = 5f;

    public float areaWidth = 16f;
    public float areaHeight = 10f;

    private Vector3 targetPosition;
    public float changeTargetInterval = 2f; // ÿ��2�����һ��Ŀ��λ��
    private float timer;

    public GameObject blueSpawn; // �ο���
    public float minDistance = 5f; // ��С����

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

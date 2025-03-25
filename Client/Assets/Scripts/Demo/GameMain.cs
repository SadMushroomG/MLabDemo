using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMain : MonoBehaviour
{
    [LabelText("红方主塔")]
    public BuildingBase redSpawn;

    [LabelText("蓝方主塔")]
    public BuildingBase blueSpawn;   

    [LabelText("红方Data")]
    public PlayerDataManager redPlayerData;

    [LabelText("蓝方Data")]
    public PlayerDataManager bluePlayerData;   

    public int initActorCount = 5;

    public Transform bulletRoot;

    private bool isGameing = false;
    public static float globalTime = 0;
    public static float deltaTime = 0;

    public static GameMain Instance
    {
        get 
        {
            if (instance == null)
            {
                instance = GameObject.FindObjectOfType<GameMain>();
            }
            return instance; 
        }
    }
    private static GameMain instance;


    public Transform GetTransformTarget(MLabActorType type)
    {
        switch (type)
        {
            case MLabActorType.SpwanA:
                return redSpawn.transform;
            case MLabActorType.SpwanB:
                return blueSpawn.transform;
            default:
                return null;
        }
    }

    public MLabActorType GetTargeType(MLabActorType type)
    {
        switch (type)
        {
            case MLabActorType.SpwanA:
                return MLabActorType.PlayerB;
            case MLabActorType.SpwanB:
                return MLabActorType.chessRed;
            case MLabActorType.chessRed:
                return MLabActorType.SpwanB;
            case MLabActorType.PlayerB:
                return MLabActorType.SpwanA;
            default:
                return MLabActorType.None;
        }
    }

    void Awake()
    {
        instance = this;
        isGameing = true;
    }

    void Update()
    {
        if (isGameing)
        {
            globalTime += Time.deltaTime;
            deltaTime = Time.deltaTime;
        }
        CheckGameOver();
    }

    private void Start()
    {
        for (int i = 0; i < initActorCount; i++)
        {
            ActorManager.Instance.SpawnActor(MLabActorType.chessRed);
            ActorManager.Instance.SpawnActor(MLabActorType.PlayerB);
        }
    }

    public void CheckGameOver()
    {
        if (redSpawn.currentHealth <= 0)
        {
            Debug.Log("蓝方胜利");
            isGameing = false;  
        }
        else if (blueSpawn.currentHealth <= 0)
        {
            Debug.Log("红方胜利");
            isGameing = false;  
        }
    }

    public static Transform GetBulletRoot()
    { 
        return Instance.bulletRoot;
    }
}

using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Sirenix.OdinInspector;
using Unity.VisualScripting;
using UnityEngine;

public class ActorManager : MonoBehaviour
{
    public static ActorManager Instance
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<ActorManager>();
            }
            return instance;
        }
    }
    private static ActorManager instance;

    [LabelText("红方棋子")]
    public GameObject actorRed;
    [LabelText("蓝方棋子")]
    public GameObject actorBlue;

    [Header("Spawn Area Settings")]
    //[LabelText("生成区域宽度")]
    //[SerializeField] private float spawnAreaWidth = 10f;
    //[LabelText("生成区域高度")]
    //[SerializeField] private float spawnAreaHeight = 10f;
    [LabelText("生成区域半径")]
    [SerializeField] private float spawnAreaRadius = 1f;
    //[LabelText("生成区域中心偏移")]
    //[SerializeField] private Vector2 spawnAreaOffset = Vector2.zero;

    public List<GameObject> redActorList = new List<GameObject>();
    public List<GameObject> blueActorList = new List<GameObject>();



    public GameObject redSeed;
    public GameObject blueSeed;

    public enum SeedStateEnum
    { 
        Moving,
        Pin
    }

    public class seedData
    {
        public GameObject seed;
        public float lifeTime;
        public Vector3 pinOffset;
        public SeedStateEnum state;
    }

    public List<seedData> redSeedList = new List<seedData>();
    public List<seedData> blueSeedList = new List<seedData>();


    private int redSpawnCount = 0;
    private int blueSpawnCount = 0;
    private Transform seedRoot;


    [BoxGroup("Seed动画设置")]
    [LabelText("移动到Circle时间")]
    public float moveToCircleTime = 1f;

    [BoxGroup("Seed动画设置")]
    [LabelText("Seed移动速度")]
    public float moveToCircleSpeed = 100f;

    [BoxGroup("Seed动画设置")]
    [LabelText("Seed Pin 阈值")]
    public float insertToCircleThreshold = 0.02f;


    void Awake()
    {
        //redActorList = GameObject.FindGameObjectsWithTag("PlayerA").ToList();
        //blueActorList = GameObject.FindGameObjectsWithTag("PlayerB").ToList();
    }

    // Update is called once per frame
    void Update()
    {
        if (redSpawnCount > 0)
        {
            for (int i = 0; i < redSpawnCount; i++)
            {
                SpawnActor(MLabActorType.chessRed);
            }
            redSpawnCount = 0;
        }

        if (blueSpawnCount > 0)
        {
            for (int i = 0; i < blueSpawnCount; i++)
            {
                SpawnActor(MLabActorType.PlayerB);
            }
            blueSpawnCount = 0;
        }

        if (redSeedList.Count > 0)
        {
            for (int i = 0; i < redSeedList.Count; i++)
            {
                var data = redSeedList[i];
                //redSeedList[i].lifeTime -= Time.deltaTime;
                var curOffset = data.seed.transform.position - GameMain.Instance.blueSpawn.transform.position;

                if ( data.state == SeedStateEnum.Moving)
                { 
                    if (Mathf.Abs(curOffset.magnitude - GameMain.Instance.blueSpawn.recycleCircleRadius) < insertToCircleThreshold)
                    {
                        data.state = SeedStateEnum.Pin;
                        data.pinOffset = curOffset;
                        var animator = data.seed.GetComponent<Animation>();
                        animator.Play("anim_seed_split");
                        data.lifeTime = 0.4f;
                    }
                    else
                    {
                        var targetPos = GameMain.Instance.blueSpawn.transform.position + curOffset.normalized * GameMain.Instance.blueSpawn.recycleCircleRadius;
                        var dir2 = targetPos - redSeedList[i].seed.transform.position;
                        redSeedList[i].seed.transform.position += dir2.normalized * GameMain.deltaTime * moveToCircleSpeed;
                    }
                }
                else
                { 
                    data.seed.transform.position = GameMain.Instance.blueSpawn.transform.position + data.pinOffset;
                    data.lifeTime -= GameMain.deltaTime;
                    if (data.lifeTime <= 0)
                    {
                        var pos0 = data.seed.transform.GetChild(1).transform.position;
                        var pos1 = data.seed.transform.GetChild(2).transform.position;
                        SpawnActor(MLabActorType.PlayerB, pos0);
                        SpawnActor(MLabActorType.PlayerB, pos1);
                        GameObject.Destroy(data.seed);
                        redSeedList.RemoveAt(i);
                        i--;
                    }
                }
            }
        }

        if (blueSeedList.Count > 0)
        {
            for (int i = 0; i < blueSeedList.Count; i++)
            {
                var data = blueSeedList[i];
                //redSeedList[i].lifeTime -= Time.deltaTime;
                var curOffset = data.seed.transform.position - GameMain.Instance.redSpawn.transform.position;

                if (data.state == SeedStateEnum.Moving)
                {
                    if (Mathf.Abs(curOffset.magnitude - GameMain.Instance.redSpawn.recycleCircleRadius) < insertToCircleThreshold)
                    {
                        data.state = SeedStateEnum.Pin;
                        data.pinOffset = curOffset;
                        var animator = data.seed.GetComponent<Animation>();
                        animator.Play("anim_seed_split");
                        data.lifeTime = 0.4f;
                    }
                    else
                    {
                        var targetPos = GameMain.Instance.redSpawn.transform.position + curOffset.normalized * GameMain.Instance.redSpawn.recycleCircleRadius;
                        var dir2 = targetPos - redSeedList[i].seed.transform.position;
                        redSeedList[i].seed.transform.position += dir2.normalized * GameMain.deltaTime * moveToCircleSpeed;
                    }
                }
                else
                {
                    data.seed.transform.position = GameMain.Instance.redSpawn.transform.position + data.pinOffset;
                    data.lifeTime -= GameMain.deltaTime;
                    if (data.lifeTime <= 0)
                    {
                        var pos0 = data.seed.transform.GetChild(1).transform.position;
                        var pos1 = data.seed.transform.GetChild(2).transform.position;
                        SpawnActor(MLabActorType.chessRed, pos0);
                        SpawnActor(MLabActorType.chessRed, pos1);
                        GameObject.Destroy(data.seed);
                        blueSeedList.RemoveAt(i);
                        i--;
                    }
                }
            }
        }
    }

    public void SpawnActor(MLabActorType actorType, Vector3 targetPosition)
    {
        GameObject actor = actorType == MLabActorType.chessRed ? actorRed : actorBlue;

        var instance = Instantiate(actor, targetPosition, Quaternion.identity);

        if (actorType == MLabActorType.PlayerB)
        {
            blueActorList.Add(instance);
        }
        else
        {
            redActorList.Add(instance);
        }
    }

    public void SpawnActor(MLabActorType actorType)
    {
        GameObject actor = actorType == MLabActorType.chessRed ? actorRed : actorBlue;

        var position = Vector3.zero;
        if (actorType == MLabActorType.chessRed)
        {
            position = GameMain.Instance.redSpawn.transform.position;
        }
        else
        {
            position = GameMain.Instance.blueSpawn.transform.position;
        }


        // Calculate random position within spawn area
        var random = Random.insideUnitCircle * spawnAreaRadius;
        position.x += random.x;
        position.y += random.y;

        var instance = Instantiate(actor, position, Quaternion.identity);

        if (actorType == MLabActorType.PlayerB)
        {
            blueActorList.Add(instance);
        }
        else
        {
            redActorList.Add(instance);
        }
    }

    public void RemoveActor(GameObject actor, MLabActorType actorType)
    {
        if (actorType == MLabActorType.chessRed)
        {
            GameMain.Instance.blueSpawn.GetExp(actor.GetComponent<ActorBase>().expValue);
            redActorList.Remove(actor);

            AddSeed(actorType, actor.transform.position);
            blueSpawnCount += 2;
        }
        else
        {
            GameMain.Instance.redSpawn.GetExp(actor.GetComponent<ActorBase>().expValue);
            blueActorList.Remove(actor);
            redSpawnCount += 2;
        }
        Destroy(actor);
    }


    public void AddSeed(MLabActorType actorType, Vector2 startPosition)
    { 
        if(seedRoot == null)
        {
            var root = new GameObject("seed_root");
            root.transform.parent = transform;
        }

        var seed = actorType == MLabActorType.chessRed ? redSeed : blueSeed;
        var go = Instantiate(seed, seedRoot);
        go.transform.position = startPosition;

        if (actorType == MLabActorType.chessRed)
        {
            redSeedList.Add(new seedData
            {
                seed = go,
                lifeTime = 5f,
                state = SeedStateEnum.Moving
            });
        }
        else if (actorType == MLabActorType.PlayerB)
        {
            blueSeedList.Add(new seedData
            {
                seed = go,
                lifeTime = 5f,
                state = SeedStateEnum.Moving
            });
        }
    }


#if UNITY_EDITOR
    private void OnDrawGizmosSelected()
    {
        //// Draw spawn area in editor
        //Gizmos.color = new Color(0, 1, 0, 0.3f);
        //Vector3 center = transform.position + new Vector3(spawnAreaOffset.x, spawnAreaOffset.y, 0);
        //Gizmos.DrawCube(center, new Vector3(spawnAreaWidth, spawnAreaHeight, 0.1f));
        
        //// Draw outline
        //Gizmos.color = Color.green;
        //Gizmos.DrawWireCube(center, new Vector3(spawnAreaWidth, spawnAreaHeight, 0.1f));
    }
#endif
}

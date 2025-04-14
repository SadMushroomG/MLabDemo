using Sirenix.OdinInspector;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEditor;
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

    public TMP_Text updateTipText;

    public TMP_Text waveText;
    
    public int waveCount = 1;

    public float updateCountDownTime = 30;

    public enum GameStateEnum
    {
        Gameing,
        Pause,
        GameOver,
    }
    public GameStateEnum gameState;
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

    private Dictionary<string, BaseViewController> controllerDic = new();
    private List<BaseViewController> controllerList = new();

    [LabelText("UIRoot")]
    public GameObject uiRoot;

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
        //isGameing = true;
        gameState = GameStateEnum.Gameing;
        InitModules();
    }

    public void InitGame()
    {
        gameState = GameStateEnum.Gameing;
        globalTime = 0;
        deltaTime = 0;
        updateCountDownTime = 15;
        SetWaveCount(1);
    }

    private IEnumerator PauseGameAfterDelay(float delay)
    {
        yield return new WaitForSecondsRealtime(delay);
        if (controllerDic.ContainsKey("CardPoolViewContoller"))
        {
            if (controllerDic["CardPoolViewContoller"].isShow)
            { 
                Time.timeScale = 0f; // 暂停游戏
            }
        }
    }

    void Update()
    {
        if (gameState == GameStateEnum.Gameing)
        {
            globalTime += Time.deltaTime;
            deltaTime = Time.deltaTime;

            updateCountDownTime -= deltaTime;

            if (updateCountDownTime <= 0)
            {
                gameState = GameStateEnum.Pause;
                if(controllerDic.ContainsKey("CardPoolViewContoller"))
                {
                    controllerDic["CardPoolViewContoller"].Show();
                    StartCoroutine(PauseGameAfterDelay(1f));
                }
            }
            else
            {
                updateTipText.text = TimeSpan.FromSeconds(updateCountDownTime).ToString(@"mm\:ss");
            }
        }
        else
        {
            deltaTime = 0f;
        }

        foreach (var controller in controllerList)
        {
            if (controller.isShow)
            { 
                controller.Update();
            }
        }
        CheckGameOver();
    }

    public void ResumeGame()
    {
        gameState = GameStateEnum.Gameing;
        SetWaveCount(waveCount + 1);
        updateCountDownTime = 30;
        if (controllerDic.ContainsKey("PlayerInfoViewController"))
        {
            var infoView = controllerDic["PlayerInfoViewController"] as PlayerInfoViewController;
            infoView.ShowToast("~敌人好像也变强了~");
            StartCoroutine(DelayedHideToast(infoView));

            DelayedHideToast(infoView);
        }
        ActorManager.Instance.MakeEverthingBetter(waveCount);
    }

    private IEnumerator DelayedHideToast(PlayerInfoViewController infoView)
    {
        yield return new WaitForSeconds(2f);
        infoView.HideToast();
    }

    private void Start()
    {
        // 设置为窗口模式，分辨率1280x720
        Screen.SetResolution(1280, 720, FullScreenMode.Windowed);

        CursorController.SwitchCursorState(CursorState.Attack);
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
            //TODO胜利结算
            //Debug.Log("蓝方胜利");
            gameState = GameStateEnum.GameOver; 
            //Time.timeScale = 0f;
            if (controllerDic.ContainsKey("PlayerInfoViewController"))
            {
                var infoView = controllerDic["PlayerInfoViewController"] as PlayerInfoViewController;
                infoView.ShowWinView();
            }
        }
        else if (blueSpawn.currentHealth <= 0)
        {
            //TODO胜利结算
            //Debug.Log("红方胜利");
            gameState = GameStateEnum.GameOver;
            //Time.timeScale = 0f;
            if (controllerDic.ContainsKey("PlayerInfoViewController"))
            {
                var infoView = controllerDic["PlayerInfoViewController"] as PlayerInfoViewController;
                infoView.ShowLoseView();
            }
        }
    }

    public static Transform GetBulletRoot()
    { 
        return Instance.bulletRoot;
    }

    private void InitModules()
    {
        var cardController = new CardPoolViewContoller();
        cardController.Init();
        controllerDic.Add(cardController.moduleName, cardController);
        controllerList.Add(cardController);

        var infoViewController = new PlayerInfoViewController();
        infoViewController.Init();
        controllerDic.Add(infoViewController.moduleName, infoViewController);
        controllerList.Add(infoViewController);
        infoViewController.Show();
    }

    public void SetWaveCount(int waveCount)
    { 
        this.waveCount = waveCount;
        waveText.text = "WAVE " + waveCount.ToString();
    }

    #region
    private static string cardConfigPath = "Configs/CardDataConfig";
    private static CardConfigData cardDataConfig;
    public static CardConfigData CardDataConfig
    {
        get
        {
            if (cardDataConfig == null)
            {
                cardDataConfig = Resources.Load<CardConfigData>(cardConfigPath);
            }
            return cardDataConfig;
        }
    }
    #endregion
}

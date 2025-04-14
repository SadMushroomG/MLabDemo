using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class CardPoolViewContoller : BaseViewController
{
    private GameObject canvasRoot;
    private CardConfigData config;
    private List<CardComponent> cardComponentList = new();

    public override void Init()
    {
        moduleName = "CardPoolViewContoller";
        canvasRoot = GameMain.Instance.uiRoot.transform.GetChild(1).gameObject;
        config = GameMain.CardDataConfig;
        canvasRoot.GetComponentsInChildren<CardComponent>(true, cardComponentList);
    }



    public override void Show()
    {
        base.Show();
        //Time.timeScale = 0f; // 暂停游戏
        if (canvasRoot != null)
        {
            canvasRoot.SetActive(true);
        }

        for (int i = 0; i < cardComponentList.Count; i++)
        {
            int randIndex = Random.Range(0, config.cardDataList.Count - 1);
            cardComponentList[i].SetData(config.cardDataList[randIndex]);
            cardComponentList[i].GetComponent<Button>().onClick.AddListener(() => OnSelectedCard(randIndex));
        }

        CursorController.SwitchCursorState(CursorState.Normal);
    }

    public override void Hide()
    {
        base.Hide();
        Time.timeScale = 1f; // 暂停游戏

        if (canvasRoot != null)
        {
            canvasRoot.SetActive(false);
        }

        CursorController.SwitchCursorState(CursorState.Attack);
    }

    private void OnSelectedCard(int index)
    {
        // 在这里处理选中卡片的逻辑
        // 可以通过 cardComponentList[index] 来访问对应的卡片
        Debug.Log($"Selected card index: {index}");
        var data = config.cardDataList[index];
        GameMain.Instance.blueSpawn.ApplyBuff(ref data.buffDataList);
        GameMain.Instance.ResumeGame();
        Hide();
    }
}

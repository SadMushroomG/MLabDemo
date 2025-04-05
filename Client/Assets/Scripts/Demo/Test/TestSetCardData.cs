using Sirenix.OdinInspector;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class TestCardData
{
    [TableColumnWidth(60)]
    [PreviewField(Alignment = ObjectFieldAlignment.Center)]
    public Sprite characterTex;

    [TableColumnWidth(60)]
    [TextArea]
    public string cardName = "Ä¬ÈÏ¿¨ÅÆ";

    [TableColumnWidth(60)]
    [TextArea]
    public string skillDescribe = "¼¼ÄÜÃèÊöÆß¸ö×Ö";

    [TableColumnWidth(30)]
    public MGameCardQuailty cardQuailty = MGameCardQuailty.Grey;

    private TestSetCardData component;

    public TestCardData(Sprite characterTex, string cardName, string skillDescribe, MGameCardQuailty quailty, TestSetCardData component)
    {
        this.characterTex = characterTex;
        this.cardName = cardName;
        this.skillDescribe = skillDescribe;
        this.cardQuailty = quailty;
        this.component = component;
    }

    [TableColumnWidth(30)]
    [Button("Set")]
    public void SetCardData()
    {
        component.SetCardData(this);
    }
}


[ExecuteAlways]
public class TestSetCardData : MonoBehaviour
{
    private static string configPath = "Assets/Scripts/Demo/Configs/CardDataConfig.asset";
    private static CardDataConfig config;

    [TableList(ShowIndexLabels = false)]
    public List<TestCardData> cardDataList = new List<TestCardData>();



    private void OnEnable()
    {
        if (config == null)
        { 
            config = AssetDatabase.LoadAssetAtPath<CardDataConfig>(configPath);
        }
        cardDataList.Clear();
        for ( int i = 0; i < config.cardDataList.Count; i++)
        {
            var data = config.cardDataList[i];
            cardDataList.Add(new TestCardData(data.characterTex, data.cardName, data.skillDescribe, data.cardQuailty, this));
        }
    }

    public void SetCardData(TestCardData data)
    {
        var trans = GetComponentsInChildren<Transform>();
        foreach (var tran in trans)
        {
            if (tran.name == "bg")
            {
                var img = tran.GetComponent<Image>();
                img.color = config.cardColorList[(int)data.cardQuailty];
            }

            if (tran.name == "icon")
            { 
                var icon = tran.GetComponent<Image>();
                icon.sprite = data.characterTex;
            }

            if (tran.name == "txt_1")
            {
                var text = tran.GetComponent<TMP_Text>();
                text.text = data.cardName;
            }

            if (tran.name == "txt_2")
            {
                var text = tran.GetComponent<TMP_Text>();
                text.text = data.skillDescribe;
            }
        }
    }
}

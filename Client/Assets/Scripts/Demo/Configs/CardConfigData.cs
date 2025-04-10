using Sirenix.OdinInspector;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Card Config", menuName = "M-Game Data/Card Data")]
public class CardDataConfig : ScriptableObject
{
    [TableList(ShowIndexLabels = false)]
    public List<CardData> cardDataList = new();

    [BoxGroup("抽卡概率")]
    [LabelText("灰色卡牌概率")]
    public float greyCardRate = 0.8f;

    [BoxGroup("抽卡概率")]
    [LabelText("蓝色卡牌概率")]
    public float blueCardRate = 0.1f;
    
    [BoxGroup("抽卡概率")]
    [LabelText("紫色卡牌概率")]
    public float purpleCardRate = 0.08f;
    
    [BoxGroup("抽卡概率")]
    [LabelText("橙色卡牌概率")]
    public float orangeCardRate = 0.02f;

    [BoxGroup("卡牌颜色")]
    public List<Color> cardColorList = new();
}

[Serializable]
public class CardData
{
    [TableColumnWidth(60, Resizable = false)]
    public string cardGroupId = "000";

    [TableColumnWidth(60, Resizable = false)]
    [PreviewField(Alignment = ObjectFieldAlignment.Center)]
    public Sprite buffIcon;

    [TableColumnWidth(60, Resizable = false)]
    [PreviewField(Alignment = ObjectFieldAlignment.Center)]
    public Sprite characterTex;

    [TableColumnWidth(60, Resizable = false)]
    [PreviewField(Alignment = ObjectFieldAlignment.Center)]
    public Sprite characterShadowTex;

    [TableColumnWidth(60, Resizable = false)]
    public MGameCardQuailty cardQuailty = MGameCardQuailty.Grey;

    [TableColumnWidth(60)]
    [TextArea]
    public string cardName = "默认卡牌";

    [TableColumnWidth(60)]
    [TextArea]
    public string skillDescribe = "技能描述七个字";

    [TableColumnWidth(120)]
    [TableList(ShowIndexLabels = false)]
    public List<BuffData> buffDataList = new();
}

[Serializable]
public class BuffData
{
    public int buffId = 0;
    public BuffType buffType;
    public BuffCalculateType buffCalculateType;
    public BuffCalculateFunction buffFunction;
    public float buffValue;
}

public enum BuffType
{
    [LabelText("Use Id")]
    UseId,
    [LabelText("攻击")]
    Attack,
    [LabelText("暴击率")]
    CritRate,
    [LabelText("暴击伤害")]
    CritDamange,
    [LabelText("攻击速度")]
    AttackSpeed
}

public enum BuffCalculateType
{
    [LabelText("百分比")]
    Percent,
    [LabelText("固定值")]
    FixedValue
}

public enum BuffCalculateFunction
{
    [LabelText("增加固定值")]
    Add,
    [LabelText("乘")]
    Multiply
}

public enum MGameCardQuailty
{
    [LabelText("灰色")]
    Grey,

    //[LabelText("绿色")]
    //Green,

    [LabelText("蓝色")]
    Blue,

    [LabelText("紫色")]
    Purple,

    [LabelText("橙色")]
    Orange,
}
using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CardComponent : MonoBehaviour
{
    [LabelText("����ͼ")]
    public Image bg;

    [LabelText("��ɫͼ")]
    public Image image;

    [LabelText("��������")]
    public TMP_Text cardName;

    [LabelText("��������")]
    public TMP_Text skillDescribe;
    
    public void SetData(CardData data)
    {
        bg.color = GameMain.CardDataConfig.cardColorList[(int)data.cardQuailty];
        image.sprite = data.characterTex;
        cardName.text = data.cardName;
        skillDescribe.text = data.skillDescribe;
    }
}

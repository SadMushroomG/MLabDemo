using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CardComponent : MonoBehaviour
{
    [LabelText("±³¾°Í¼")]
    public Image bg;

    [LabelText("½ÇÉ«Í¼")]
    public Image image;

    [LabelText("¿¨ÅÆÃû³Æ")]
    public TMP_Text cardName;

    [LabelText("¿¨ÅÆÃèÊö")]
    public TMP_Text skillDescribe;
    
    public void SetData(CardData data)
    {
        bg.color = GameMain.CardDataConfig.cardColorList[(int)data.cardQuailty];
        image.sprite = data.characterTex;
        cardName.text = data.cardName;
        skillDescribe.text = data.skillDescribe;
    }
}

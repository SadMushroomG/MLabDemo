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

    [LabelText("Í¼±ê")]
    public Image icon;

    [LabelText("±³¾°Í¼±ê")]
    public Image iconBg;

    [LabelText("½ÇÉ«Í¼")]
    public Image hero;

    [LabelText("½ÇÉ«ÒõÓ°Í¼")]
    public Image heroShadow;

    [LabelText("Æ·ÖÊ")]
    public Image quality;

    [LabelText("Æ·ÖÊ×Ö")]
    public TMP_Text qualitytext;

    [LabelText("¿¨ÅÆÃû³Æ")]
    public TMP_Text cardName;

    [LabelText("¿¨ÅÆÃèÊö")]
    public TMP_Text skillDescribe;
    public void SetData(CardData data)
    {
        bg.color = GameMain.CardDataConfig.cardColorList[(int)data.cardQuailty];
        icon.sprite = data.buffIcon;
        iconBg.sprite = data.buffIcon;
        hero.sprite = data.characterTex;
        heroShadow.sprite = data.characterShadowTex;
        quality.color = GameMain.CardDataConfig.cardColorList[(int)data.cardQuailty];
        //qualitytext.text = GameMain.CardDataConfig.cardTextList[(int)data.cardQuailty];
        cardName.text = data.cardName;
        skillDescribe.text = data.skillDescribe;
        TypeImageChange(data);
    }
    public void TypeImageChange(CardData data)
    {
        
        if(data.cardGroupId == "»ù´¡")
        {
            iconBg.enabled = true;
            hero.enabled = false;
            heroShadow.enabled = false;
        }
        else if(data.cardGroupId == "Ó¢ÐÛ")
        {
            iconBg.enabled = false;
            hero.enabled = true;
            heroShadow.enabled = true;

        }
        else
        {
            iconBg.enabled = false;
            hero.enabled = false;
            heroShadow.enabled = false;

        }


        if(data.cardQuailty == MGameCardQuailty.Grey)
        {
            qualitytext.text = "ÆÕÍ¨";
        }
        else if(data.cardQuailty == MGameCardQuailty.Blue)
        {
            qualitytext.text = "Ï¡ÓÐ";
        }
        else if (data.cardQuailty == MGameCardQuailty.Purple)
        {
            qualitytext.text = "Ê·Ê«";
        }
        else if (data.cardQuailty == MGameCardQuailty.Orange)
        {
            qualitytext.text = "ÉñÓò";
        }

    }
}

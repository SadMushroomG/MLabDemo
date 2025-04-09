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

    [LabelText("ͼ��")]
    public Image icon;

    [LabelText("����ͼ��")]
    public Image iconBg;

    [LabelText("��ɫͼ")]
    public Image hero;

    [LabelText("��ɫ��Ӱͼ")]
    public Image heroShadow;

    [LabelText("Ʒ��")]
    public Image quality;

    [LabelText("Ʒ����")]
    public TMP_Text qualitytext;

    [LabelText("��������")]
    public TMP_Text cardName;

    [LabelText("��������")]
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
        
        if(data.cardGroupId == "����")
        {
            iconBg.enabled = true;
            hero.enabled = false;
            heroShadow.enabled = false;
        }
        else if(data.cardGroupId == "Ӣ��")
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
            qualitytext.text = "��ͨ";
        }
        else if(data.cardQuailty == MGameCardQuailty.Blue)
        {
            qualitytext.text = "ϡ��";
        }
        else if (data.cardQuailty == MGameCardQuailty.Purple)
        {
            qualitytext.text = "ʷʫ";
        }
        else if (data.cardQuailty == MGameCardQuailty.Orange)
        {
            qualitytext.text = "����";
        }

    }
}

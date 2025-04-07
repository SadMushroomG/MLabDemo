using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class PlayerInfoViewController : BaseViewController
{
    private GameObject canvasRoot;
    private TMP_Text attackDamageTxt;
    private TMP_Text coolDownTxt;
    private TMP_Text critRateTxt;
    private TMP_Text critDamageTxt;
    private bool isTextInit = false;
    public override void Init()
    {
        moduleName = "PlayerInfoViewController";
        canvasRoot = GameMain.Instance.uiRoot.transform.GetChild(2).gameObject;
        var binder = canvasRoot.GetComponent<MLabBinder>();
        if (binder != null)
        { 
            attackDamageTxt = binder.nodeList[0].node.GetComponent<TMP_Text>();
            coolDownTxt = binder.nodeList[1].node.GetComponent<TMP_Text>();
            critRateTxt = binder.nodeList[2].node.GetComponent<TMP_Text>();
            critDamageTxt = binder.nodeList[3].node.GetComponent<TMP_Text>();
        }
    }

    public override void Show()
    {
        base.Show();
        UpdateText();
    }

    public override void Hide()
    {
        base.Hide();
    }

    public override void Update()
    {
        if (!isTextInit || GameMain.Instance.blueSpawn.IsStateDirty)
        {
            UpdateText();
        }
    }

    private void UpdateText()
    {
        var hero = GameMain.Instance.blueSpawn;
        if (hero == null)
        {
            return;
        }
        var weapon = hero.mainWeapon;
        if (weapon == null)
        {
            return;
        }

        var damageStr = $"{weapon.damage + weapon.DamageAdd}";
        if (weapon.DamageAdd > 0)
        { 
            damageStr += $" <color=green>(+{weapon.DamageAdd})</color>";
        }
        attackDamageTxt.text = damageStr;

        var coolDownStr = $"{weapon.attackCooldown / weapon.AttackCooldownMultiParam}";
        if (weapon.AttackCooldownMultiParam != 1)
        {
            coolDownStr += $" <color=green>(±¶ÂÊ {weapon.AttackCooldownMultiParam})</color>";
        }
        coolDownTxt.text = coolDownStr;


        var critRateStr = $"{weapon.critRate + weapon.CritRateAdd}";
        if (weapon.CritRateAdd != 0)
        {
            critRateStr += $" <color=green>(+{weapon.CritRateAdd})</color>";
        }
        critRateTxt.text = critRateStr;

        var critDamageStr = $"{weapon.critDamage + weapon.CritDamageAdd}";
        if(weapon.CritDamageAdd != 0)
        {
            critDamageStr += $" <color=green>(+{weapon.CritDamageAdd})</color>";
        }
        critDamageTxt.text = critDamageStr;

        GameMain.Instance.blueSpawn.IsStateDirty = false;
        isTextInit = true;
    }
}

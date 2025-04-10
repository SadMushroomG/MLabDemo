using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;

public class PlayerInfoViewController : BaseViewController
{
    private GameObject canvasRoot;
    private TMP_Text attackDamageTxt;
    private TMP_Text coolDownTxt;
    private TMP_Text critRateTxt;
    private TMP_Text critDamageTxt;

    private Transform bloodRedTrans;
    private Transform bloodBlueTrans;

    private GameObject winView;
    private GameObject loseView;
    private GameObject ToastText;

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

            bloodRedTrans = binder.nodeList[4].node.transform;
            bloodBlueTrans = binder.nodeList[5].node.transform;

            loseView = binder.nodeList[6].node;
            winView = binder.nodeList[7].node;
            ToastText = binder.nodeList[8].node;

            loseView.GetComponent<Button>().onClick.AddListener(() =>
            {
                SceneManager.LoadScene("MenuScene");
            });

            winView.GetComponent<Button>().onClick.AddListener(() =>
            {
                SceneManager.LoadScene("MenuScene");
            });
        }
    }
    public void ShowWinView()
    {
        winView.SetActive(true);
        loseView.SetActive(false);
    }

    public void ShowLoseView()
    {
        winView.SetActive(false);
        loseView.SetActive(true);
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

        bloodBlueTrans.localScale = new Vector3(Mathf.Clamp01(GameMain.Instance.blueSpawn.currentHealth / GameMain.Instance.blueSpawn.maxHealth), 1, 1);
        bloodRedTrans.localScale = new Vector3(Mathf.Clamp01(GameMain.Instance.redSpawn.currentHealth / GameMain.Instance.redSpawn.maxHealth), 1, 1);
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

        var coolDownStr = $"{(weapon.attackCooldown / weapon.AttackCooldownMultiParam):0.0}";
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

    public void ShowToast(string text)
    {
        ToastText.SetActive(true);
        ToastText.GetComponentInChildren<TMP_Text>().text = text;
    }

    public void HideToast()
    {
        ToastText.SetActive(false);
    }

}

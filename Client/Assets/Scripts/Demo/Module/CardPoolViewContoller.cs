using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class CardPoolViewContoller : BaseViewController
{
    private GameObject canvasRoot;

    public override void Init()
    {
        moduleName = "CardPoolViewContoller";
        canvasRoot = GameMain.Instance.uiRoot.transform.GetChild(1).gameObject;
    }

    public override void Show()
    {
        if (canvasRoot != null)
        {
            canvasRoot.SetActive(true);
        }
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseViewController
{
    public string moduleName = "BaseViewController";
    public bool isShow = false;

    public virtual void Init()
    {
    }

    public virtual void Show()
    {
        isShow = true;
    }

    public virtual void Hide()
    {
        isShow = false;
    }

    public virtual void Update()
    {
    }

    public virtual void Close()
    {
        isShow = false;
    }
}

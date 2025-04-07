using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class MLabBinderData
{
    public string nodeName;
    public GameObject node;
}
public class MLabBinder : MonoBehaviour
{
    public List<MLabBinderData> nodeList;
}

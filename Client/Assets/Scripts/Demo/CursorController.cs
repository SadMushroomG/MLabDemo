using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public enum CursorState
{
    Normal,
    Attack,
    Move,
    Skill,
}

public class CursorController : MonoBehaviour
{
    public static CursorController Instance
    {
        get
        {
            if (instance == null)
            {
                instance = GameObject.FindObjectOfType<CursorController>();
            }
            return instance;
        }
    }
    private static CursorController instance;
    public GameObject attackCursor;
    public CursorState curCursorState = CursorState.Normal;

    private void Awake()
    {
        instance = this;
    }

    void Start()
    {
    }

    void Update()
    {
        if (curCursorState == CursorState.Attack)
        {
            attackCursor.transform.position = Input.mousePosition;
        }
    }

    public static void SwitchCursorState(CursorState state)
    {
        if (state == CursorState.Normal)
        {
            Cursor.visible = true;
            instance.attackCursor.SetActive(false);
        }
        else if (state == CursorState.Attack)
        {
            Cursor.visible = false;
            instance.attackCursor.gameObject.SetActive(true);
        }
        Instance.curCursorState = state;
    }
}

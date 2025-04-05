using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class JumpWordHelper : MonoBehaviour
{
    public static JumpWordHelper Instance
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<JumpWordHelper>();
            }
            return instance;
        }
    }
    private static JumpWordHelper instance;


    protected void Awake()
    {
        instance = this;
    }

    [Serializable]
    public class JumpWordData
    {
        public GameObject prefab;
        public float lifeTime;
    }

    public JumpWordData jumpWordHero;
    public JumpWordData jumpWordHeroCrit;

    public JumpWordData jumpWordEnemy;
    public JumpWordData jumpWordEnemyCrit;

    public Transform jumpWordRoot;

    private struct JumpWordRecord
    {
        public GameObject jumpWord;
        public float lifeTime;
    }
    private List<JumpWordRecord> jumpWordRecords = new List<JumpWordRecord>();

    /// <summary>
    /// Éú³ÉÌø×Ö
    /// </summary>
    /// <param name="text"></param>
    /// <param name="position"></param>
    public void GenerateJumpWord(MLabActorType type, string text, Vector2 position, bool isCrit = false)
    {
        GameObject jumpWordObject = null;
        if (type == MLabActorType.chessRed || type == MLabActorType.SpwanA)
        {
            if (jumpWordEnemy == null)
                return;

            jumpWordObject = isCrit ? Instantiate(jumpWordEnemyCrit.prefab, position, Quaternion.identity) : Instantiate(jumpWordEnemy.prefab, position, Quaternion.identity);
        }
        else if (type == MLabActorType.PlayerB || type == MLabActorType.SpwanB)
        {
            if (jumpWordHero == null)
                return;

            jumpWordObject = isCrit ? Instantiate(jumpWordHeroCrit.prefab, position, Quaternion.identity) : Instantiate(jumpWordHero.prefab, position, Quaternion.identity);
        }

        jumpWordObject.transform.SetParent(jumpWordRoot.transform);
        
        var tmp = jumpWordObject.GetComponentInChildren<TMP_Text>();
        if(tmp != null)
        {
            tmp.text = text;
        }
        
        jumpWordRecords.Add(new JumpWordRecord
        {
            jumpWord = jumpWordObject,
            lifeTime = jumpWordHero.lifeTime
        });
    }

    protected void Update()
    {
        for (int i = 0; i < jumpWordRecords.Count; i++)
        {
            JumpWordRecord record = jumpWordRecords[i];
            record.lifeTime -= GameMain.deltaTime;
            if (record.lifeTime <= 0)
            {
                Destroy(record.jumpWord);
                jumpWordRecords.RemoveAt(i);
                i--;
            }
            else
            {
                jumpWordRecords[i] = record;
            }
        }
    }
}

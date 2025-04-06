using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class StartMenuController : MonoBehaviour
{
    public Button startBtn;
    
    void Awake()
    {
        startBtn.onClick.AddListener(() => SwitchToGameMain());
    }

    private void SwitchToGameMain()
    {
        UnityEngine.SceneManagement.SceneManager.LoadScene("GameMain");
    }
}

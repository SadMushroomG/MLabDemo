using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class StartMenuController : MonoBehaviour
{
    public Button startBtn;
    
    void Awake()
    {
        // 设置为窗口模式，分辨率1280x720
        Screen.SetResolution(1280, 720, FullScreenMode.Windowed);
        startBtn.onClick.AddListener(() => SwitchToGameMain());
    }

    private void SwitchToGameMain()
    {
        UnityEngine.SceneManagement.SceneManager.LoadScene("GameMain");
    }
}

//using UnityEngine;
//using UnityEngine.UI;

///// <summary>
///// 挂在物体上，调用instance截图
///// </summary>
//public class GrabScreen : MonoBehaviour
//{
//    [Tooltip("降低分辨率：越大越模糊，性能消耗降低")]
//    public int downSample = 2;

//    public bool OnEnableGrab = false;

//    [Tooltip("在界面打开前，预先截取图片")]
//    public bool PreGrab = false;
    
//    [Tooltip("迭代次数：越大模糊越平滑，性能消耗变大")] 
//    public int iteration = 3;
    
//    [Tooltip("模糊度，越大越糊")] [Range(0, 1)]
//    public float blur = 1;
        
//    [Tooltip("Blur effect mode")] [SerializeField]
//    BlurMode m_BlurMode = BlurMode.Medium;
    
//    public RawImage BackgroundRawImage;

//    private bool isGrabScreen = false;
//    private RenderTexture _renderTexture;
    
//    [Tooltip("用等比缩放铺满屏幕")]
//    public bool ForceFullScreen = true;
    
//    int lastScreenWidth;
//    int lastScreenHeight;

//    private bool isResetAnchor = false;

//    private CanvasScaler _scaler;

//    private bool isInApplicationQuit;
    
//    void Awake()
//    {
//        if (BackgroundRawImage == null)
//        {
//            BackgroundRawImage = transform.GetComponent<RawImage>();

//            verifyAnchorCenterMode();
//        }
//    }
    
//    void Update()
//    {
//        verifyScreenSizeChanged();
//    }

//    void verifyAnchorCenterMode()
//    {
//        if (!ForceFullScreen || BackgroundRawImage == null)
//        {
//            return;
//        }

//        if (_scaler == null)
//            _scaler = transform.GetComponentInParent<CanvasScaler>();

        
//        var rectTransform = BackgroundRawImage.rectTransform;
//        rectTransform.localScale = Vector3.one;
        
//        rectTransform.anchorMin = new Vector2(0.5f, 0.5f);
//        rectTransform.anchorMax = new Vector2(0.5f, 0.5f);
//        rectTransform.pivot = new Vector2(0.5f, 0.5f);
        
//        if (_scaler)
//        {
//            rectTransform.sizeDelta = GrabScreenUtils.Instance.GetCanvasFullScreenWH(_scaler);
//        }
//        else
//        {
//            rectTransform.sizeDelta = new Vector2(Screen.width, Screen.height);
//        }
        
//        isResetAnchor = true;
//    }

//    void verifyScreenSizeChanged()
//    {
//        if (!ForceFullScreen)
//        {
//            return;
//        }
        
//        if (BackgroundRawImage == null)
//        {
//            return;
//        }

//        if (!isResetAnchor)
//        {
//            verifyAnchorCenterMode();
//        }

//        var sw = Screen.width;
//        var sh = Screen.height;

//        if (lastScreenWidth != sw || lastScreenHeight != sh)
//        {
//            lastScreenWidth = sw;
//            lastScreenHeight = sh;

//            OnScreenSizeChanged();
//        }
//    }

//    private void OnScreenSizeChanged()
//    {
//        ResizeImage();
//    }
    
//    public void ResizeImage()
//    {
//        var bgText = BackgroundRawImage.texture;
//        if (bgText == null)
//        {
//            return;
//        }

//        var fullScreenWh = GrabScreenUtils.Instance.GetCanvasFullScreenWH(_scaler);
        
//        float sw = fullScreenWh.x;
//        float sh = fullScreenWh.y;
        
//        var rectTransform = BackgroundRawImage.rectTransform;
//        rectTransform.sizeDelta = new Vector2(sw, sh); 
        
//        float aw = bgText.width;
//        float ah = bgText.height;

//        var texRatio = aw / ah;
        
//        float curRatio = sw / sh;
//        if (curRatio > texRatio)
//        {
//            //width is bigger
//            var texRatioInvert = 1f / texRatio;

//            float bHeight = sw * texRatioInvert;
//            float bHeightRatio = bHeight / sh;
//            rectTransform.localScale = new Vector3(1f, bHeightRatio, 1f);
//        }
//        else
//        {
//            //height is bigger
//            float bWidth = sh * texRatio;
//            float bWidthRatio = bWidth / sw;
//            rectTransform.localScale = new Vector3(bWidthRatio, 1f, 1f);
//        }
//    }
    
//    private void OnEnable()
//    {
//        if (!OnEnableGrab && isGrabScreen)
//        {
//            return;
//        }

//        if (BackgroundRawImage == null)
//        {
//            Debug.LogWarning($"Current PrefabRes {gameObject.name} don't have RawImage Component, GrabScreen Will not worked!");
//            return;
//        }
        
//        verifyAnchorCenterMode();
        
//        if (PreGrab)
//        {
//            //Debug.Log("Grab OnEnable PreGrab! Start!" );
//            _renderTexture = GrabScreenUtils.Instance.ApplyPreGrab(BackgroundRawImage);
//            isGrabScreen = true;
//        }
//        else
//        {
//            //Debug.Log("Grab OnEnable StartGrab! Start!");
//            GrabScreenUtils.Instance.StartGrab(BackgroundRawImage, blur, m_BlurMode, transform, downSample, iteration, rt => { _renderTexture = rt; });
//            isGrabScreen = true;
//        }
//    }

//    private void OnDisable()
//    {
//        if (!isGrabScreen)
//        {
//            return;
//        }

//        if (OnEnableGrab)
//        {
//            if (_renderTexture != null)
//            {
//                GrabScreenUtils.Instance.ReleaseRt(_renderTexture);
//            }

//            isGrabScreen = false;
//        }
//    }

//    public void ReleaseRt()
//    {
//        isGrabScreen = false;
        
//        if (_renderTexture != null)
//        {
//            GrabScreenUtils.Instance.ReleaseRt(_renderTexture);
//        }
//    }

//    private void OnApplicationQuit()
//    {
//        isInApplicationQuit = true;
//    }
    
//    private void OnDestroy()
//    {
//        //in application quit to call instance will create a new GrabScreen on the scene 
//        //will cause some error msg report
//        if (!isInApplicationQuit)
//        {
//            if (_renderTexture != null)
//            {
//                GrabScreenUtils.Instance.ReleaseRt(_renderTexture);
//            }    
//        }

//        BackgroundRawImage = null;
//        isGrabScreen = false;
//    }

//    [ContextMenu("StartGrab")]
//    private void StartGrab()
//    {
//        if (BackgroundRawImage == null)
//        {
//            Debug.LogWarning($"Current PrefabRes {gameObject.name} don't have RawImage Component, GrabScreen Will not worked!");
//            return;
//        }
        
//        verifyAnchorCenterMode();
//        ResizeImage();
        
//        GrabScreenUtils.Instance.StartGrab(BackgroundRawImage, blur, m_BlurMode, transform, downSample, iteration);
//    }
//}
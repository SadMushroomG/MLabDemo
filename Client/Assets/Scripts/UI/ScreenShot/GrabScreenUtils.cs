//using System.Collections;
//using System.Collections.Generic;
//using System;
//using UnityEngine;
//using UnityEngine.Rendering;
//using UnityEngine.Rendering.Universal;
//using UnityEngine.UI;
//using Debug = UnityEngine.Debug;
//using UnityEngine.Rendering.Universal.Internal;

//public enum BlurMode
//{
//    None = 0,
//    Fast,
//    Medium,
//    Detail,
//}

//public class GrabScreenUtils : RenderPassComponent
//{
//    /// <summary>
//    /// Blur effect mode.
//    /// </summary>
//    private int downSample = 2;

//    private readonly Queue<CanvasGroup> rootGroups = new Queue<CanvasGroup>(2);

//    private RawImage TargetRawImage;

//    private RenderTexture TargetRt;

//    private int iteration = 3;

//    private float blur = 1;

//    private Material blurMat;

//    private Func<int> _funcComplete;

//    //private BlurMode m_BlurMode = BlurMode.Medium;
//    //private static readonly int EffectFactor = Shader.PropertyToID("_EffectFactor");
//    //private int targetIndexTest = 1;

//    private readonly Dictionary<RenderTexture, int> _referenceCount = new(7);

//    private bool startGrabImg;
//    private bool isSetUICamera;

//    private Camera curRenderCamera;

//    private Camera mainCamCache;
//    private Camera mainCam => mainCamCache != null ? mainCamCache : (mainCamCache = Camera.main);

//    private ProfilingSampler profilingSampler;

//    public bool OpenLog;
    
//    public static int kBlurSizeGlobalKey = Shader.PropertyToID("_BlurSize");

//    private static GrabScreenUtils m_Instance;

//    public static GrabScreenUtils Instance
//    {
//        get
//        {
//            if (m_Instance != null) return m_Instance;

//            m_Instance = FindObjectOfType(typeof(GrabScreenUtils)) as GrabScreenUtils;

//            if (m_Instance == null)
//            {
//                GameObject obj = new GameObject(nameof(GrabScreenUtils));
//                DontDestroyOnLoad(obj);
//                m_Instance = obj.AddComponent<GrabScreenUtils>();
//            }

//            return m_Instance;
//        }
//    }

//    private void Awake()
//    {
//        if (m_Instance == null)
//        {
//            m_Instance = this;
//        }
//    }

//    private void OnDestroy()
//    {
//        //unRegist events
//        this.Dispose();
        
//        RenderPipelineManager.beginCameraRendering -= RenderPipelineManager_beginCameraRendering;
//        RenderPassManager.instance.Uregister(this);
        
//        _referenceCount.Clear();
        
//        m_Instance = null;
//        curRenderCamera = null;
//        isSetUICamera = false;
//    }

//    protected override void OnCreate(RenderPassComponentFeature feature)
//    {
//        renderPass.renderPassEvent = RenderPassEvent.AfterRenderingTransparents;

//        profilingSampler = new ProfilingSampler("GrabScreenBlur");

//        //blurMat = EngineUtils.CreateMaterial(feature.Get<Shader>("GaussionBlur"));

//        //The new One
//        blurMat = EngineUtils.CreateMaterial(feature.Get<Shader>("GaussionBlur"));

//        //The old one
//        // if (blurMat == null)
//        // {
//        //     var blurShader = Shader.Find("Hidden/StaticBlur");
//        //     if (blurShader == null)
//        //     {
//        //         Debug.LogError("Grab Hidden/StaticBlur.shader找不到");
//        //         return;
//        //     }
//        //
//        //     blurMat = new Material(blurShader);
//        //     if (0 < m_BlurMode)
//        //         blurMat.EnableKeyword($"UI_BLUR_{m_BlurMode.ToString().ToUpper()}");
//        //     
//        //     blurMat.SetVector(EffectFactor, new Vector4(0, 0, blur, 0));
//        // }

//        //startGrabImg = false;
//    }

//    protected override bool IsActiveForCamera(Camera camera)
//    {
//        if (curRenderCamera == null && TargetRawImage == null)
//        {
//            curRenderCamera = mainCam;
//            DebugUtil.LogW("Current Render camera is missing blur effect may not be worked");

//            isSetUICamera = false;
            
//            //startGrabImg = false;
//            return false;
//        }

//        if (curRenderCamera == null)
//        {
//            curRenderCamera = TargetRawImage.canvas.worldCamera;
//        }

//        return curRenderCamera == camera;
//    }

//    protected override void Clearnup()
//    {
//        if (blurMat != null)
//        {
//            EngineUtils.DestoryObject(blurMat);
//        }

//        blurMat = null;
//        curRenderCamera = null;
//        startGrabImg = false;
//    }

//    public override bool blitBackBuffer => startGrabImg;

//    protected override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
//    {
//        if (!startGrabImg || curRenderCamera == null)
//        {
//            return;
//        }

//        ref var cameraData = ref renderingData.cameraData;
//        ScriptableRenderer sr = cameraData.renderer;

//        var des = cameraData.cameraTargetDescriptor;
//        des.depthBufferBits = 0;
//        des.msaaSamples = 1;
//        des.width = des.width >> downSample;
//        des.height = des.height >> downSample;

//        // captureRT.width = des.width >> downSample;
//        // captureRT.height = des.height >> downSample;

//        var cmd = CommandBufferPool.Get();

//        if (TargetRt != null && !_referenceCount.ContainsKey(TargetRt))
//        {
//#if UNITY_EDITOR
//            Debug.LogError($"[GrabBlurFeature] {TargetRt.name} 泄漏了！");
//#endif            
//            ReleaseRt(TargetRt);
//        }
        
//        using (new ProfilingScope(cmd, profilingSampler))
//        {
//            if (iteration == 0)
//            {
//                //no need blur just output current screen
//                if(RenderStatus.rtUseTemp)
//                {
//                    TargetRt = RenderTexture.GetTemporary(Screen.width, Screen.height, 0, RenderTextureFormat.Default);
//                }
//                else
//                {
//                    TargetRt = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.Default);
//                    TargetRt.autoGenerateMips = false;
//                    TargetRt.useMipMap = false;
//                    TargetRt.Create();
//                }
               
//                EngineUtils.Blit(cmd, sr.cameraColorTarget, TargetRt);
//            }
//            else
//            {
//                cmd.GetTemporaryRT(PassCompoentProperty._TempTarget0, des, FilterMode.Bilinear);
//                cmd.GetTemporaryRT(PassCompoentProperty._TempTarget1, des, FilterMode.Bilinear);

//                // Take current camera picture to rt
//                EngineUtils.Blit(cmd, sr.cameraColorTarget, PassCompoentProperty._TempTarget0);

//                GetBlurTargetRT(cmd, PassCompoentProperty._TempTarget0, PassCompoentProperty._TempTarget1);

//                cmd.ReleaseTemporaryRT(PassCompoentProperty._TempTarget0);
//                cmd.ReleaseTemporaryRT(PassCompoentProperty._TempTarget1);
//            }
//        }

//        context.ExecuteCommandBuffer(cmd);
//        CommandBufferPool.Release(cmd);

//        startGrabImg = false;
//    }

//    public void StartGrab(RawImage TargetRawImage, float blur, BlurMode blurMode, Transform disableTrans = null, int downSample = 2, int iteration = 3, Action<RenderTexture> onRtSet = null)
//    {
//        Log("Grab StartGrab! Start!");

//        this.downSample = downSample;
//        this.TargetRawImage = TargetRawImage;
//        this.iteration = iteration;
//        this.blur = blur;
//        //this.m_BlurMode = blurMode;

//        if (disableTrans != null)
//        {
//            if (!disableTrans.TryGetComponent<CanvasGroup>(out var rootGroup))
//            {
//                rootGroup = disableTrans.gameObject.AddComponent<CanvasGroup>();
//            }

//            rootGroup.alpha = 0;
//            rootGroups.Enqueue(rootGroup);
//        }

//        // Set Render camera
//        if (TargetRawImage != null)
//        {
//            setRenderCameraByDefault();
//        }

//        // grab screen
//        StartCoroutine(CaptureByUI(onRtSet));
//    }

//    public void SetCompleteFunc(Func<int> func)
//    {
//        _funcComplete = func;
//    }

//    public IEnumerator CaptureByUI(Action<RenderTexture> onRtSet)
//    {
//        Log("Grab CaptureByUI! Start!");

//        startGrabImg = true;

//        //wait for render pipline to capture img
//        while (startGrabImg)
//        {
//            yield return null;
//        }

//        //yield return new WaitForEndOfFrame();

//        if (TargetRawImage)
//        {
//            TargetRawImage.texture = TargetRt;
//            onRtSet?.Invoke(TargetRt);
//            IncreaseReference(TargetRt);

//            TargetRawImage.color = new Color(TargetRawImage.color.r, TargetRawImage.color.g, TargetRawImage.color.b, 1f);

//            _funcComplete?.Invoke();

//            Log("Grab _funcComplete! Over!");
//        }
//        else
//        {
//            DebugUtil.LogW("TargetRawImage is null! 请检查prefab！");
//        }

//        while (rootGroups.Count != 0)
//        {
//            var rootGroup = rootGroups.Dequeue();
//            if (rootGroup != null)
//            {
//                rootGroup.alpha = 1;
//            }
//        }
//    }

//    public void SetParams(float blur, int downSample, int iteration)
//    {
//        this.blur = blur;
//        this.downSample = downSample;
//        this.iteration = iteration;
//    }

//    private void GetBlurTargetRT(CommandBuffer cmd, RenderTargetIdentifier rt1, RenderTargetIdentifier rt2)
//    {
//        //The old one material 
//        // if (0 < m_BlurMode)
//        //     blurMat.EnableKeyword($"UI_BLUR_{m_BlurMode.ToString().ToUpper()}");
//        // blurMat.SetVector(EffectFactor, new Vector4(0, 0, blur, 0));

//        //进行迭代，一次迭代进行了两次模糊操作，使用两张RT交叉处理
//        for (int i = 0; i < iteration; i++)
//        {
//            //用降过分辨率的RT进行模糊处理
//            cmd.SetGlobalFloat(kBlurSizeGlobalKey, blur * 2f + i);

//            EngineUtils.Blit(cmd, rt1, rt2, blurMat, 0);
//            EngineUtils.Blit(cmd, rt2, rt1, blurMat, 1);
//        }


//        //毛叔：缩小了RT尺寸，关闭AutoGenerateMipMap
//        if (RenderStatus.rtUseTemp)
//        {
//            TargetRt = RenderTexture.GetTemporary(Screen.width >> 1, Screen.height >> 1, 0, RenderTextureFormat.Default);
//        }
//        else
//        {
//            TargetRt = new RenderTexture(Screen.width >> 1, Screen.height >> 1, 0, RenderTextureFormat.Default);
//            //这边RT是那Temporary的 所以不能设置了
//            TargetRt.autoGenerateMips = false;
//            TargetRt.Create();
//        }
        
        
//        //TargetRt.name = $"TargetRt{targetIndexTest}";
//        //Debug.Log($"Grab Create! {TargetRt.name}");
//        //targetIndexTest++;
//        //cmd.SetGlobalTexture("_UICaptureTex", TargetRt);
//        //将结果拷贝到目标RT
//        cmd.Blit(rt1, TargetRt);

//        // //释放申请的两块RenderBuffer内容
//        // RenderTexture.ReleaseTemporary(rt1);
//        // RenderTexture.ReleaseTemporary(rt2);

//        Log($"Grab Over!blur:{blur} downSample:{downSample} iteration:{iteration}");
//    }

//    /// <summary>
//    /// 预先截取一张图片，等待GrabScreen调用
//    /// </summary>
//    public void PreGrab(Action callback = null)
//    {
//        verifyUICamera();
        
//        StartCoroutine(_preGrab(callback));
//    }

//    private IEnumerator _preGrab(Action callback)
//    {
//        Log("Pre grab Start!");

//        if (curRenderCamera == null)
//        {
//            setRenderCameraByDefault();
//        }

//        startGrabImg = true;

//        //wait for render pipline to capture img
//        while (startGrabImg)
//        {
//            yield return null;
//        }

//        callback?.Invoke();
//        // yield return new WaitForEndOfFrame();
//    }

//    private void verifyUICamera()
//    {
//        if (isSetUICamera)
//        {
//            return;
//        }

//        setRenderCameraByDefault();

//        if (curRenderCamera != null)
//        {
//            isSetUICamera = true;
//        }
//    }
    
//    private void setRenderCameraByDefault()
//    {
//        var mainCamera = mainCam;
//        if (mainCamera == null)
//        {
//            DebugUtil.LogE("Main Camera is Not Found!!");
//            return;
//        }

//        Camera targetCamera = mainCamera;

//        var cameraData = mainCamera.GetComponent<UniversalAdditionalCameraData>();

//        foreach (var c in cameraData.cameraStack)
//        {
//            if (c.enabled && string.Equals(c.name, "UICamera", StringComparison.OrdinalIgnoreCase))
//            {
//                targetCamera = c;
//                break;
//            }
//        }

//        curRenderCamera = targetCamera;
//    }

//    public RenderTexture ApplyPreGrab(RawImage rawImage)
//    {
//        if (TargetRt == null)
//        {
//            Log("ApplyPreGrab TargetRt is null!");
//            return null;
//        }

//        if (rawImage == null)
//        {
//            Log("ApplyPreGrab TargetRawImage is null!");
//            return null;
//        }

//        Log("Apply PreGrab is null!");

//        TargetRawImage = rawImage;
//        rawImage.texture = TargetRt;
//        IncreaseReference(TargetRt);
//        rawImage.color = new Color(rawImage.color.r, rawImage.color.g, rawImage.color.b, 1f);
//        return TargetRt;
//    }

//    public void ReleaseRt(RenderTexture rt)
//    {
//        DecreaseReference(rt);
//    }
    
//    public void ClearRtByHand()
//    {
//        if (_referenceCount == null)
//        {
//            return;
//        }
        
//        //释放所有的RT
//        //有些特殊的情况，会导致内存泄漏，但是因为强更可能要在很久很久之后，不能马上处理
//        //所以这里提供一个手动释放的接口，来提供lua hard code 的可能性
//        foreach (var kv in _referenceCount)
//        {
//            var rt = kv.Key;
//            if (rt == null)
//            {
//                continue;
//            }
            
//            DebugUtil.LogD($"[GrabScreenUtils] ClearRtByHand! {rt.name} with count {kv.Value}");

//            if (RenderStatus.rtUseTemp)
//            {
//                RenderTexture.ReleaseTemporary(rt);
//            }
//            else
//            {
//                rt.Release();
//                Destroy(rt);
//            }
//        }
        
//        _referenceCount.Clear();
//    }

//    private void IncreaseReference(RenderTexture renderTexture)
//    {
//        Log($"Grab IncreaseReference! {renderTexture.name}");
//        if (_referenceCount.TryGetValue(renderTexture, out var count))
//        {
//            _referenceCount[renderTexture] = count + 1;
//        }
//        else
//        {
//            _referenceCount.Add(renderTexture, 1);
//        }
//    }

//    private void DecreaseReference(RenderTexture renderTexture)
//    {
//        Log($"Grab DecreaseReference! {renderTexture.name}");

//        bool isTargetRt = TargetRt == renderTexture;

//        if (_referenceCount.TryGetValue(renderTexture, out var count))
//        {
//            var newCount = count - 1;

//            if (newCount == 0)
//            {
//                Log($"Grab ReleaseTexture! {renderTexture.name}");
//                _referenceCount.Remove(renderTexture);
//                if(RenderStatus.rtUseTemp)
//                {
//                    RenderTexture.ReleaseTemporary(renderTexture);
//                }
//                else
//                {
//                    renderTexture.Release();
//                    //强制手动destroy 不然C#的壳子要等待GC
//                    Destroy(renderTexture);
//                }

//                if (isTargetRt)
//                {
//                    TargetRt = null;
//                }
//            }
//            else
//            {
//                _referenceCount[renderTexture] = newCount;
//            }
//        }
//        else
//        {
//            Log($"Grab ReleaseTexture! {renderTexture.name}");
//            if (RenderStatus.rtUseTemp)
//            {
//                RenderTexture.ReleaseTemporary(renderTexture);
//            }
//            else
//            {
//                renderTexture.Release();
//                //强制手动destroy 不然C#的壳子要等待GC
//                Destroy(renderTexture);
//            }
            
//            if (isTargetRt)
//            {
//                TargetRt = null;
//            }
//        }
//    }

//    public Vector2 GetCanvasFullScreenWH(CanvasScaler scaler)
//    {
//        float sw = Screen.width;
//        float sh = Screen.height;

//        var scaleFactor = GetCanvasScale(scaler);
//        var scaleFactorInvert = 1f / scaleFactor;
        
//        return new Vector2(sw, sh) * scaleFactorInvert;
//    }
    
//    public float GetCanvasScale(CanvasScaler scaler)
//    {
//        if (scaler == null)
//        {
//            return 1f;
//        }
        
//        if (scaler.uiScaleMode == CanvasScaler.ScaleMode.ScaleWithScreenSize)
//        {
//            var scalerReferenceResolution = scaler.referenceResolution;
//            var scalerMatchWidthOrHeight = scaler.matchWidthOrHeight;
        
//            return Mathf.Pow(Screen.width / scalerReferenceResolution.x, 1f - scalerMatchWidthOrHeight) *
//                   Mathf.Pow(Screen.height / scalerReferenceResolution.y, scalerMatchWidthOrHeight);
//        }

//        return scaler.scaleFactor;
//    }
    
//    [System.Diagnostics.Conditional("UNITY_EDITOR")]
//    private void Log(string msg)
//    {
//        if (!OpenLog)
//        {
//            return;
//        }

//        Debug.Log($"[GrabBlurFeature] {msg}");
//    }
//}
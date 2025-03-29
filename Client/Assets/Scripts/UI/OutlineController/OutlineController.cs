//https://lilithgames.feishu.cn/wiki/W7Quw4sx5ii46nkSxTScEcTWnkb
//written by Haidong
//2024.05.18
//OutlineController

using UnityEngine;
using UnityEngine.UI;
using Sirenix.OdinInspector;

[ExecuteInEditMode]
[RequireComponent(typeof(RawImage))]
public class OutlineController : MonoBehaviour
{
    //资源参数。

    [LabelText("图像")]
    public Texture rawTexture;

    [LabelText("纹理")]
    public Texture displayTexture;

    [LabelText("算法Shader")]
    [HideInInspector]
    public Shader blurShader; 

    [LabelText("显示Shader")]
    [HideInInspector]
    public Shader displayShader;

  
    private RawImage rawImage;
    private float smoothStepX = 0.01f;

    RenderTexture destRenderTexture;
    RenderTexture sourceRenderTexture;
    private Material blurMaterial;
    private Material displayMaterial;

    //美术参数。

    [PropertySpace(15)]
    [LabelText("描边粗细")] 
    [Range(0f, 1f)]
    public float widthTmp = 0f;
    private float width;

    [PropertySpace(SpaceBefore = 0, SpaceAfter = 15)]
    [LabelText("描边颜色")]
    [ColorUsage(true, true)]
    public Color hdrColorTmp = Color.white;
    private Color hdrColor;

    [PropertySpace(15)]
    [FoldoutGroup("其他参数")]
    [LabelText("平滑度")]
    [Range(0f, 1f)]
    public float smoothTmp = 1f;
    private float smooth;

    [FoldoutGroup("其他参数")]
    [LabelText("迭代次数")]
    [Range(0, 4)]
    public int iterTmp = 2;
    private int iterations;

    [InfoBox("迭代次数过多会造成性能负担，可适当使用平滑度弥补。", InfoMessageType.Info)]
    [FoldoutGroup("其他参数")]
    [LabelText("纹理流动速度X")] 
    public float speedXTmp = 0f;
    private float speedX;

    [FoldoutGroup("其他参数")]
    [LabelText("纹理流动速度Y")]
    public float speedYTmp = 1f;
    private float speedY;

    [FoldoutGroup("其他参数")]
    [LabelText("纹理旋转")]
    [Range(0f, 360f)]
    public float rotationTmp = 0f;
    private float rotation;

    [FoldoutGroup("其他参数")]
    [PropertySpace(SpaceBefore = 10, SpaceAfter = 15)]
    [Button("默认值", ButtonSizes.Medium), GUIColor(0.91f, 0.91f, 0.94f)]
    private void Default()
    {
        iterTmp = 2;
        widthTmp = 1;
        speedXTmp = 0;
        speedYTmp = 1;
        smoothTmp = 1f;
        rotationTmp = 0f;
    }

    //初始化阶段。
    
    private void Setup()
    {
        rawImage = GetComponent<RawImage>();

        if (rawImage == null)
            rawImage = gameObject.AddComponent<RawImage>();

        if (blurShader != null && blurMaterial == null)
            blurMaterial = new Material(blurShader);

        if (displayShader != null && displayMaterial == null && blurShader != null)
            displayMaterial = new Material(displayShader);

    }

    private void OnEnable()
    {
        Setup();
        //检查初始化情况。
        //处理一开始就有描边的情况。
        if (widthTmp != 0f && iterTmp != 0f && rawImage != null && displayMaterial != null && rawTexture != null)
        {
            //对齐临时变量。
            Alignment();
            //计算。
            Process();
        }
        else if (rawImage != null && rawTexture != null)
        {
            rawImage.texture = rawTexture;
            rawImage.SetNativeSize();
        }
    }

    private void Start()
    {
        Setup();
        if (displayMaterial == null) //只有start方法可以检测默认是否存在Shader,写在Enabled里会一直报错。
        {

            Debug.Log("Shader missing! Please specify default shaders and Re-add the script.");
            enabled = false;
        }
    }

    //运行阶段。

    private void Update()
    {
        if (blurMaterial == null || rawImage == null)
            Setup();
        //描边不存在时自动释放rt。
        if (widthTmp == 0f || iterTmp == 0f)
        {
            Alignment();
            if (rawImage != null && rawTexture != null)
            {
                rawImage.texture = rawTexture;
                rawImage.SetNativeSize();
            }
            if (sourceRenderTexture != null)
            {
                RenderTexture.ReleaseTemporary(sourceRenderTexture);
                sourceRenderTexture = null;
            }
        }
        //和临时变量对比，在值被变更时才运行算法。
        else if (widthTmp!= width || iterTmp != iterations || smooth != smoothTmp )
        {
            Alignment();
            if(rawImage != null && rawTexture != null)
            {
                if(displayMaterial != null)
                    Process();
                else
                {
                    rawImage.texture = rawTexture;
                    rawImage.SetNativeSize();
                } 
            }
        }
        //不需要运行算法的情况。
        else if(speedX != speedXTmp|| speedY != speedYTmp || hdrColorTmp != hdrColor || rotation != rotationTmp)
        {
            Alignment();
            if(displayMaterial != null)
            {
                SetDisplayMat();
            }
            else if(rawImage != null && rawTexture != null)
            {
                rawImage.texture = rawTexture;
                rawImage.SetNativeSize();
            }
        }
    }
    private void Alignment()
    {
        width = widthTmp;
        iterations = iterTmp;
        smooth = smoothTmp;
        speedX = speedXTmp;
        speedY = speedYTmp;
        hdrColor = hdrColorTmp;
        rotation = rotationTmp;
    }

    //整体流程。
    private void Process()
    {
        GetRT();  //获取RT。
        SetBlurMat();  //处理算法材质。
        ApplyGaussianBlur();  //运行算法。
        RenderTexture.ReleaseTemporary(destRenderTexture);  //清理无用RT。
        destRenderTexture = null;
        if (displayMaterial != null) //处理显示材质。
            SetDisplayMat();
    }

    private void GetRT()
    {
        if (sourceRenderTexture == null)  //主RT只需获得一次。
            sourceRenderTexture = RenderTexture.GetTemporary(rawTexture.width, rawTexture.height, 0);
        destRenderTexture = RenderTexture.GetTemporary(rawTexture.width, rawTexture.height, 0);
    }

    private void SetBlurMat()
    {
        blurMaterial.SetFloat("_SmoothStepX", smoothStepX);
        //数值映射。
        blurMaterial.SetFloat("_SmoothStepY", Mathf.Lerp(Mathf.Lerp(1.25f, 0.935f, width * 3.8f), Mathf.Lerp(0.935f, 0.2f, width), width < 0.3 ? width / 0.3f : 1));
        blurMaterial.SetFloat("_BlurSize", Mathf.Lerp(0.013f, 0.12f, smooth));
    }

    private void ApplyGaussianBlur()
    {
        Graphics.Blit(rawTexture, sourceRenderTexture);
        //至多只需要两个rt。
        for (int i = 1; i <= iterations; i++)
        {
            Graphics.Blit(sourceRenderTexture, destRenderTexture, blurMaterial);
            Graphics.Blit(destRenderTexture, sourceRenderTexture, blurMaterial);
        }
        rawImage.texture = sourceRenderTexture;
    }

    private void SetDisplayMat()
    {
        displayMaterial.SetTexture("_IconTex", rawTexture);
        displayMaterial.SetColor("_FlowCol", hdrColor);
        //纹理流动、描边透明度。
        if (displayTexture != null)
        {
            displayMaterial.SetTexture("_FlowTex", displayTexture);
            displayMaterial.SetFloat("_SpeedX", -speedX);
            displayMaterial.SetFloat("_SpeedY", -speedY);
            displayMaterial.SetFloat("_RotationAngle", rotation);
        }
        rawImage.material = displayMaterial;
    }

    //结束阶段。

    private void OnDisable()
    {
        //清理临时材质球和RT。
        if(rawTexture!= null)
            rawImage.texture = rawTexture;
        if (sourceRenderTexture != null)
        {
            RenderTexture.ReleaseTemporary(sourceRenderTexture);
            sourceRenderTexture = null;
        }
        DestroyImmediate(blurMaterial);
        DestroyImmediate(displayMaterial);
    }
}
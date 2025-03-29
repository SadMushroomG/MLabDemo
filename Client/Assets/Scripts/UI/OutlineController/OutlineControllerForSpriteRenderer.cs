//https://lilithgames.feishu.cn/wiki/W7Quw4sx5ii46nkSxTScEcTWnkb
//written by Haidong
//2024.05.18
//OutlineController

using UnityEngine;
using UnityEngine.UI;
using Sirenix.OdinInspector;

[ExecuteInEditMode]
[RequireComponent(typeof(SpriteRenderer))]
public class OutlineControllerForSpriteRenderer : MonoBehaviour
{
    //资源参数。

    [LabelText("图像")]
    public Sprite oriSprite;
    private Sprite prevSprite;

    [LabelText("算法Shader")]
    [HideInInspector]
    public Shader blurShader; 

    [LabelText("显示Shader")]
    [HideInInspector]
    public Shader displayShader;
  
    private SpriteRenderer spriteRenderer;

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

    private const string materialName = "[AutoGenerate]SpriteOutlineMaterial";

    [InfoBox("迭代次数过多会造成性能负担，可适当使用平滑度弥补。", InfoMessageType.Info)]

    [FoldoutGroup("其他参数")]
    [PropertySpace(SpaceBefore = 10, SpaceAfter = 15)]
    [Button("默认值", ButtonSizes.Medium), GUIColor(0.91f, 0.91f, 0.94f)]
    private void Default()
    {
        iterTmp = 2;
        widthTmp = 1;
        smoothTmp = 1f;
    }

    //初始化阶段。
    private void Awake()
    {
    }

    private void Setup()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();

        if (spriteRenderer == null)
            spriteRenderer = gameObject.AddComponent<SpriteRenderer>();

        if (blurShader != null && blurMaterial == null)
            blurMaterial = new Material(blurShader);

        if (displayShader != null)
            displayMaterial = new Material(displayShader);

        displayMaterial.name = materialName; 

        SetupSpriteTransform();

        prevSprite = oriSprite;
    }

    private void SetupSpriteTransform()
    {
        var size = oriSprite.bounds.size;
        var size2 = spriteRenderer.sprite.bounds.size;
        var scale = new Vector3(size.x / size2.x, size.y / size2.y, 1);
        spriteRenderer.transform.localScale = scale;
        spriteRenderer.transform.localPosition = new Vector3(scale.x * oriSprite.bounds.center.x / transform.lossyScale.x, scale.y * oriSprite.bounds.center.y / transform.lossyScale.y, spriteRenderer.transform.localPosition.z);
    }

    private void OnEnable()
    {
        Setup();

        //检查初始化情况。
        //处理一开始就有描边的情况。
        if (widthTmp != 0f && iterTmp != 0f && spriteRenderer != null && displayMaterial != null && oriSprite != null)
        {
            //对齐临时变量。
            Alignment();
            //计算。
            Process();
        }
    }

    private void Start()
    {
        if (displayMaterial == null) //只有start方法可以检测默认是否存在Shader,写在Enabled里会一直报错。
        {
            Debug.Log("Shader missing! Please specify default shaders and Re-add the script.");
            enabled = false;
        }
    }

    //运行阶段。

    private void Update()
    {
        //描边不存在时自动释放rt。
        if (widthTmp == 0f || iterTmp == 0f)
        {
            Alignment();
            if (sourceRenderTexture != null)
            {
                RenderTexture.ReleaseTemporary(sourceRenderTexture);
                sourceRenderTexture = null;
            }
        }
        //和临时变量对比，在值被变更时才运行算法。
        else if (widthTmp!= width || iterTmp != iterations || smooth != smoothTmp || oriSprite != prevSprite)
        {
            Alignment();
            if(spriteRenderer != null && oriSprite != null)
            {
                if(displayMaterial != null)
                    Process();
            }
        }
        //不需要运行算法的情况。
        else if( hdrColorTmp != hdrColor)
        {
            Alignment();
            if(displayMaterial != null)
            {
                SetDisplayMat();
            }
        }
    }
    private void Alignment()
    {
        width = widthTmp;
        iterations = iterTmp;
        smooth = smoothTmp;
        hdrColor = hdrColorTmp;

        if (prevSprite != oriSprite)
        {
            SetupSpriteTransform();
        }
        prevSprite = oriSprite;
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
            sourceRenderTexture = RenderTexture.GetTemporary(oriSprite.texture.width, oriSprite.texture.height, 0);
        destRenderTexture = RenderTexture.GetTemporary(oriSprite.texture.width, oriSprite.texture.height, 0);
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
        Graphics.Blit(oriSprite.texture, sourceRenderTexture);
        //至多只需要两个rt。
        for (int i = 1; i <= iterations; i++)
        {
            Graphics.Blit(sourceRenderTexture, destRenderTexture, blurMaterial);
            Graphics.Blit(destRenderTexture, sourceRenderTexture, blurMaterial);
        }

        SetDisplayMat();
    }

    private void SetDisplayMat()
    {
        displayMaterial.SetTexture("_OutlineTexture", sourceRenderTexture);
        displayMaterial.SetColor("_MainColor", hdrColor);
        spriteRenderer.sharedMaterial = displayMaterial;
    }

    //结束阶段。

    private void OnDisable()
    {
        //清理临时材质球和RT。
        if (sourceRenderTexture != null)
        {
            RenderTexture.ReleaseTemporary(sourceRenderTexture);
            sourceRenderTexture = null;
        }
        DestroyImmediate(blurMaterial);
        DestroyImmediate(displayMaterial);
    }

    private void OnDestroy()
    {
    }
}
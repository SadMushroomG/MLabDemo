//ver3.5.4 iGame 组件复制适配 https://lilithgames.feishu.cn/wiki/wikcnDvbLbdSIuTZ0ZDy5K81MRe
using UnityEngine;
using UnityEngine.UI;
using TMPro;

//[RequireComponent(typeof(RawImage))]
[ExecuteAlways]
public class FxControlUniversal : MonoBehaviour
{
    public bool controlOtherObject = false;
    public GameObject targetObject;
    // isDifferentMat
    public Material matOrigin;                  // public:m_matOrigin can be inherited
    public Material matCurrent;                 // public:m_matCurrent can be inherited
    private Material m_matDefault = null;
    //public RawImage rawImage = null;            // public:editor can get the value 
    //public Image image = null;                  // public:editor can get the value 
    public Graphic image = null;                // public:editor can get the value 
    public Renderer render = null;
    public TMP_Text tmPro = null;
    
    public bool isDifferent = false;

    public bool isControl = true;
    private bool m_preIsDifferent = false;
    private bool m_preIsPlaying = false;
    private bool[] m_isHadProperty = new bool[9];
    private bool[] m_keywordState = new bool[2];

    // float
    public string _stringF1 = null;
    public string _stringF2 = null;
    public string _stringF3 = null;
    public string _stringF4 = null;
    public string _stringF5 = null;
    public float _float1 = 0;
    public float _float2 = 0;
    public float _float3 = 0;
    public float _float4 = 0;
    public float _float5 = 0;
    
    public string _stringKW1 = null;
    public string _stringKW2 = null;
    public float _keywordVal1 = 0;
    public float _keywordVal2 = 0;

    // vector
    public string _stringV1 = null;
    public string _stringV2 = null;
    public Vector4 _vector1 = new Vector4(1, 1, 0, 0);
    public Vector4 _vector2 = new Vector4(1, 1, 0, 0);
    public Vector4 _vectoring = new Vector4(1, 1, 0, 0);

    // color
    public string _stringC1 = null;
    public string _stringC2 = null;
    [ColorUsage(true, true)]
    public Color _color1 = Color.white;
    [ColorUsage(true, true)]
    public Color _color2 = Color.white;

    private GameObject targetGo;

    /// <summary>
    /// 首次应用材质参数
    /// </summary>
    void InitOnceMatParam()
    {
        targetGo = controlOtherObject ? targetObject : gameObject;
        if (targetGo == null)
        {
            return;
        }

        if (image != null || render != null || tmPro != null)
        {
            return;
        }
        image = targetGo.GetComponent<Graphic>();
        tmPro = targetGo.GetComponent<TMP_Text>();
         if (image == null&tmPro == null)
        {
            render = targetGo.GetComponent<Renderer>();
        }
    
        if (image != null & tmPro == null)
        {
            if (image.material && image.material.name.StartsWith("[Copy]"))
            {
                return;
            }
            matOrigin = matCurrent = image.material;
            m_matDefault = image.defaultMaterial;
            
            Debug.Assert(m_matDefault != null, "Ojbect: " + this.name + " m_matDefault is null");
            Debug.Assert(matOrigin != null, "Ojbect: " + this.name + " .m_matOrigin is null");
            Debug.Assert(matCurrent != m_matDefault, "Ojbect: " + this.name + " Has Material Which Cant Not Be Default UI");
            return;
        }
        else if (render != null)
        {
            if (render.sharedMaterial && render.sharedMaterial.name.StartsWith("[Copy]"))
            {
                return;
            }
            matOrigin = matCurrent = render.sharedMaterial;
            m_matDefault = render.sharedMaterial;

            // Debug.Log(render.sharedMaterial.name+"11");
            return;

        }
        else if(tmPro != null)
        {
            if (tmPro.fontSharedMaterial && tmPro.fontSharedMaterial.name.StartsWith("[Copy]"))
            {
                return;
            }
            matOrigin = matCurrent = tmPro.fontSharedMaterial;
            m_matDefault = tmPro.fontSharedMaterial;
            return;
        }

        if(!controlOtherObject)
            Debug.LogError( "Ojbect: " + this.name + ", Not Found Component:RawImage Or Image Or Renderer");
    }

    /// <summary>
    /// 是否应用差异材质球
    /// </summary>
    void ApplyDifferentMaterial()
    {
        if (matOrigin == null)
        {
            return;
        }
        
        if (m_preIsDifferent == isDifferent && matCurrent)
        {
            return;
        }
        m_preIsDifferent = isDifferent;
        if (isDifferent && matOrigin && !matOrigin.name.StartsWith("[Copy]"))
        {
            matCurrent = new Material(matOrigin);
            matCurrent.name = "[Copy]" + matOrigin.name;
        }
        else
        {
            if (image != null && tmPro == null && matCurrent != m_matDefault && matCurrent != matOrigin)
            {
                DestroyImmediate(matCurrent);
            }
            else if (render != null && matCurrent != m_matDefault)
            {
                DestroyImmediate(matCurrent);
            }
            else if(tmPro != null)
            {
                DestroyImmediate(matCurrent);
            }
           matCurrent = matOrigin;


        }
        if (image != null & tmPro == null)
        {
            image.material = matCurrent;
        }
       else if (render != null)
        {
            render.sharedMaterial = matCurrent;
 
        }
        else if(tmPro != null)
        {
            tmPro.fontSharedMaterial = matCurrent;
        }
    }

    /// <summary>
    /// 检查参数是否存在&&是否发生变化
    /// </summary>
    void CheckAllProperty()
    {
        int i = 0;
        CheckEachString(_stringF1, i++);
        CheckEachString(_stringF2, i++);
        CheckEachString(_stringF3, i++);
        CheckEachString(_stringF4, i++);
        CheckEachString(_stringF5, i++);
        CheckEachString(_stringV1, i++);
        CheckEachString(_stringV2, i++);
        CheckEachString(_stringC1, i++);
        CheckEachString(_stringC2, i);
    }

    /// <summary>
    /// 检查string值是否存在
    /// </summary>
    /// <param name="_string"></param>
    /// <param name="_index"></param>
    void CheckEachString(string _string, int _index)
    {
        m_isHadProperty[_index] = _string != "" && matCurrent != null && matCurrent.HasProperty(_string) ? true : false;
    }

    /// <summary>
    /// 应用材质球参数
    /// </summary>
    void ApplyMaterialParam()
    {
        //这里是1.2.1加进去的代码，1.3.1生效 by 毛叔石琦
        if (targetGo == null || (controlOtherObject && (targetGo != targetObject)))
        {
            targetGo = controlOtherObject ? targetObject : gameObject;
            render = null;
            image = null;
            tmPro = null;
            m_preIsDifferent = false;
            if (Application.isPlaying)
            {
                if (isDifferent & matCurrent != m_matDefault)
                {
                    DestroyImmediate(matCurrent);
                }
                matOrigin = null;
                m_matDefault = null;
            }
            if (targetGo == null)
                return;
            InitMatParam();
        }

        if (matCurrent != null && matOrigin != null && matCurrent == matOrigin)//&& image.material != matOrigin)
        {   // 是否更换材质，重新赋默认值
            if (image != null & tmPro == null)
            {
                if (image.material != matOrigin)
                {
                    matOrigin = matCurrent = image.material;
                }

            }
           else if (render != null)
            {
                if (render.sharedMaterial != matOrigin)
                {
                    matOrigin = matCurrent = render.sharedMaterial;
                }

            }
            else if(tmPro != null)
            {
                   if (tmPro.fontSharedMaterial != matOrigin)
                {
                    matOrigin = matCurrent = tmPro.fontSharedMaterial;
                }
            }


        }
        int i = 0;
        // float
        IsNeedSetFloat(_stringF1, _float1, i++);
        IsNeedSetFloat(_stringF2, _float2, i++);
        IsNeedSetFloat(_stringF3, _float3, i++);
        IsNeedSetFloat(_stringF4, _float4, i++);
        IsNeedSetFloat(_stringF5, _float5, i++);

        // vector
        IsNeedSetVector(_stringV1, _vector1, i++);
        IsNeedSetVector(_stringV2, _vector2, i++);

        // color
        IsNeedSetColor(_stringC1, _color1, i++);
        IsNeedSetColor(_stringC2, _color2, i);

        // keyword
        SetKeyword(_stringKW1, _keywordVal1);
        SetKeyword(_stringKW2, _keywordVal2);
    }

    private void OnEnable()
    {
        InitMatParam();

        if (isControl)
        {
            ApplyMaterialParam();
        }
    }
    private void OnDisable()
    {
        //image = null;
        //tmPro = null;
        //render = null;
        m_preIsDifferent = false;
    }
    void OnValidate()
    {
        InitMatParam();
    }

    public void InitMatParam()
    {
        InitOnceMatParam();
        ApplyDifferentMaterial();

        CheckAllProperty();
    }

    void LateUpdate()
    {
        var curIsPlaying = Application.isPlaying;
        if (m_preIsPlaying && !curIsPlaying)
        {
            InitMatParam();
        }
        m_preIsPlaying = curIsPlaying;

        if (isControl)
        {
            ApplyMaterialParam();
        }
    }

    /// <summary>
    /// 设置float
    /// </summary>
    /// <param name="_string"></param>
    /// <param name="_float"></param>
    /// <param name="_index"></param>
    private void IsNeedSetFloat(string _string, float _float, int _index)
    {
        if (m_isHadProperty[_index])   //_string != "" && matCurrent.HasProperty(_string)
        {
            float _value = matCurrent.GetFloat(_string);
            if (_value != _float)
            {
                matCurrent.SetFloat(_string, _float);
            }
        }
    }

    /// <summary>
    /// 设置vector
    /// </summary>
    /// <param name="_string"></param>
    /// <param name="_vector"></param>
    /// <param name="_index"></param>
    private void IsNeedSetVector(string _string, Vector4 _vector, int _index)
    {
        if (m_isHadProperty[_index])
        {
            Vector4 _value = matCurrent.GetVector(_string);
            if (_value != _vector)
            {
                matCurrent.SetVector(_string, _vector);
            }
        }
    }

    /// <summary>
    /// 设置color
    /// </summary>
    /// <param name="_string"></param>
    /// <param name="_color"></param>
    /// <param name="_index"></param>
    private void IsNeedSetColor(string _string, Color _color, int _index)
    {
        if (m_isHadProperty[_index])
        {
            Color _value = matCurrent.GetColor(_string);
            if (_value != _color)
            {
                matCurrent.SetColor(_string, _color);
            }
        }
    }


    /// <summary>
    /// 设置Keyword
    /// </summary>
    private void SetKeyword(string _string, float _value)
    {
        if (_string == "")
            return;

        if (_value == 1.0f)
        {
            if (matCurrent.IsKeywordEnabled(_string))
                return;
            matCurrent.EnableKeyword(_string);
        }
        else
        {
            if (!matCurrent.IsKeywordEnabled(_string))
                return;
            matCurrent.DisableKeyword(_string);
        }
    }

    public void RefreshMaterial()
    {
        matCurrent = matOrigin =  image.material;
        m_preIsDifferent = false;
        ApplyDifferentMaterial();
        Debug.Log("[TATest]Refresh Material");
    }

     void OnDestroy()
    {
        if (Application.isPlaying)
        {
            if (isDifferent & matCurrent != m_matDefault)
            {
                DestroyImmediate(matCurrent);
            }
            matOrigin = null;
            m_matDefault = null;
        }
    }
}


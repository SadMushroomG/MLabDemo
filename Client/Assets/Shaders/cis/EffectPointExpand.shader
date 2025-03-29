//https://lilithgames.feishu.cn/wiki/TLnmwt7mDiiPEHkcLTAcwpPCn2f
Shader "UEP/Interface/PointExpand"
{
    Properties
    {
        [HideInInspector]_MainTex ("Texture", 2D) = "white" {}

        _BgTex ("_BgTex", 2D) = "white" {}
        _CellTex ("_CellTex", 2D) = "white" {}
        _ControlParam("_ControlParam(x:点数量 y:圈数量 z:内圈大小 w:外圈大小)", Vector) = (30, 12, 1.5, -1)
        _FillRate("_FillRate(图案填充比例)", Float) = 0.4
        _FlowSpeed("_FlowSpeed(流动速度)", Float) = 0.5

        [KeywordEnum(Gap, Normal, Tornado)] _ShapeType("_ShapeType(旋转类型)", Float) = 0
        [KeywordEnum(Dot, Tex)] _TextureType("_TextureType(图案类型)", Float) = 0
        _RotateParam("_RotateParam(旋转参数)", Float) = 0.5
        _SmoothStepValue ("_SmoothStepValue", Float) = 0.001

		[Header(Setting)]
        [Space(5)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

        [Header(Stencil)]
        [Space(5)]
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255

        //[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
        //[Toggle(USE_SYMMETRY)] _UseSymmetry ("Use Symmetry", Float) = 0
    
    }
    SubShader
    {
        Tags 
        { 
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull [_Cull]
        Lighting Off
        ZWrite Off
        ZTest [_ZTest]
        Blend [_SrcBlend] [_DstBlend]

        Pass
        {
            CGPROGRAM

            static const float _RADIUS_1_2 = 0.7071;
            static const float _PI_2 = 6.2832;

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma shader_feature_local _SHAPETYPE_GAP _SHAPETYPE_NORMAL _SHAPETYPE_TORNADO
            #pragma shader_feature_local _TEXTURETYPE_DOT _TEXTURETYPE_TEX

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 color : TEXCOORD1;
                float4 wPos : TEXCOORD2;
                float2 pos : TEXCOORD3;
                float scaler : TEXCOORD4;
                float2 flow : TEXCOORD5;
            };

            sampler2D _MainTex, _BgTex, _CellTex;
            float4 _ClipRect, _ControlParam;
            float4 _BgTex_ST;
            fixed _SmoothStepValue, _CellSize, _FlowSpeed, _FillRate, _RotateParam;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.wPos = v.vertex;
                o.pos = v.vertex.xy;
                o.color = v.color;
                return o;  
            }
             
            fixed4 frag (v2f i) : SV_Target
            {

                fixed colCount = _ControlParam.x;
                fixed rowCount = _ControlParam.y;

                fixed2 modUV = i.uv - fixed2(0.5, 0.5);
                fixed tOffset = (_Time.y * _FlowSpeed) % 1;

                // 按长度区分每行
                fixed oRadius = length(modUV) / _RADIUS_1_2;// 长度 加上Time Offset
                fixed radius = (oRadius - tOffset + 1) % 1;
                fixed rowNum = floor(radius * rowCount);
                float row = (rowNum + 0.5) / rowCount; // 0 - 1

                // 按角度区分每列
                fixed ang = atan2(modUV.y, modUV.x) / _PI_2 + 0.5;
            #ifdef _SHAPETYPE_GAP
                ang += (rowNum % 2) * 0.5 / colCount;
            #endif
            
            #ifdef _SHAPETYPE_NORMAL
                ang += row * _RotateParam; 
            #endif
            
            #ifdef _SHAPETYPE_TORNADO
                ang += oRadius * _RotateParam;
            #endif
                ang %= 1;

                fixed colNum = floor(ang * colCount);
                float col = _PI_2 * (colNum + 0.5) / colCount;
                
                fixed2 posCenter = ((tOffset + row + 1) % 1) * fixed2(sin(col), cos(col));
                fixed2 posContent = oRadius * fixed2(sin(ang * _PI_2), cos(ang * _PI_2));
                fixed2 cellDir = posContent - posCenter;
                
                // 控制内外图形大小的乘数
                fixed progress = length(posCenter);
                progress = _ControlParam.z + progress *(_ControlParam.w - _ControlParam.z);
                
                fixed4 result;
            #ifdef _TEXTURETYPE_TEX
                fixed porjectU = dot(cellDir, fixed2(sin(col), cos(col)));
                fixed porjectV = dot(cellDir, fixed2(sin(col - 1.57), cos(col - 1.57)));
                porjectU = porjectU * rowCount / progress + 0.5;
                porjectV = porjectV * rowCount / progress + 0.5;

                porjectU = saturate(porjectU);
                porjectV = saturate(porjectV);

                result = tex2D(_CellTex, fixed2(porjectV, porjectU));
            #else
                fixed len = length(cellDir);
                fixed val = _FillRate / rowCount * progress;
                fixed alpha = smoothstep(val, val - _SmoothStepValue, len) * i.color.a;
                
                fixed3 color = tex2D(_BgTex, i.uv * _BgTex_ST.xy + _BgTex_ST.zw);

                result = fixed4(i.color.rgb * color, alpha);
            #endif

            #ifdef UNITY_UI_CLIP_RECT
                result.a *= UnityGet2DClipping(i.wPos.xy, _ClipRect);
            #endif

                return result;
            }
            ENDCG 
        }
    }
    CustomEditor "ShaderEditorUniversal"
}
 
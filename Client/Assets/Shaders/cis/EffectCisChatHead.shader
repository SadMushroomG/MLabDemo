// https://lilithgames.feishu.cn/wiki/UPkbw4jv4ieuPzk6ur3cCwbRnHg

// 头像合并RGB框shader

Shader "UEP/Interface/ChatHead"
{
    Properties
    {
        [PerRendererData] _MainTex("_MainTex(主贴图)", 2D) = "white" {}
        _Saturation("_Saturation(饱和度)",range(0,1)) = 1
        _BorderTex("_BorderTex(边框贴图)", 2D) = "white" {}
        _BorderColor("_BorderColor(颜色)", Color) = (1,1,1,1)

        [Header(Setting)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

        [Header(Clip)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [HideInInspector]_ColorMask("Color Mask", Float) = 15
        //[HideInInspector]_GammaRadio("Gamma Radio", Float) = 1

        [Header(Stencil)]
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Comparison", Float) = 8
        _Stencil("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask("Stencil Read Mask", Float) = 255
    }

        SubShader
            {
                Tags
                {
                    "Queue" = "Transparent"
                    "IgnoreProjector" = "True"
                    "RenderType" = "Transparent"
                    "PreviewType" = "Plane"
                    "CanUseSpriteAtlas" = "True"
                }

                Stencil
                {
                    Ref[_Stencil]
                    Comp[_StencilComp]
                    Pass[_StencilOp]
                    ReadMask[_StencilReadMask]
                    WriteMask[_StencilWriteMask]
                }

                Cull[_Cull]
                Lighting Off
                ZWrite[_ZWrite]
                ZTest[_ZTest]
                Blend[_SrcBlend][_DstBlend]
                ColorMask[_ColorMask]

                Pass
                {
                    CGPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag

                    #include "UnityCG.cginc"
                    #include "UnityUI.cginc"
                    #pragma multi_compile __ UNITY_UI_CLIP_RECT
                    #pragma multi_compile __ UNITY_UI_ALPHACLIP
                    #pragma shader_feature_local __ UEP_VARIANT_1					// 3个
                    #pragma shader_feature_local __ UEP_VARIANT_2					// 4个


                    struct appdata_t
                    {
                        float4 vertex   : POSITION;
                        fixed4 color : COLOR;
                        float2 texcoord : TEXCOORD0;
                    };

                    struct v2f
                    {
                        float4 vertex   : SV_POSITION;
                        fixed4 color : COLOR;
                        float4 texcoord  : TEXCOORD0;
                    };

                    sampler2D _MainTex, _BorderTex;
                    fixed4 _BorderColor;
                    float4 _MainTex_ST, _ClipRect;
                    fixed _AlphaClipThreshold,_Saturation;

                    v2f vert(appdata_t v)
                    {
                        v2f OUT;
                        OUT.texcoord.zw = v.vertex.xy;
                        OUT.vertex = UnityObjectToClipPos(v.vertex);
                        OUT.texcoord.xy = v.texcoord;
                        OUT.color = v.color;

                        return OUT;
                    }

                    fixed4 frag(v2f IN) : SV_Target
                    {
                        // 遮罩
                        #ifdef UNITY_UI_CLIP_RECT
                            fixed out_alpha = UnityGet2DClipping(IN.texcoord.zw, _ClipRect);
                            if (out_alpha < 0.001)
                            {
                                return 0;
                            }
                        #endif

                            // 贴图采样
                            half4 chat_tex = tex2D(_MainTex, IN.texcoord.xy);
                            half4 border_tex = tex2D(_BorderTex, IN.texcoord.xy);

                            half border_mask = 0;

                            #ifdef UEP_VARIANT_1
                                border_mask = border_tex.y;
                            #elif defined (UEP_VARIANT_2)
                                border_mask = border_tex.z;
                            #else
                                border_mask = border_tex.x;
                            #endif

                            half4 color = lerp(chat_tex, _BorderColor, border_mask * _BorderColor.a);
                            color.a *= border_tex.a;
                            // 透明裁切
                            #ifdef UNITY_UI_ALPHACLIP
                                clip(color.a - _AlphaClipThreshold);
                            #endif

                            //饱和度
                            half color_lumiance = 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
                            half3 color_saturation = half3(color_lumiance,color_lumiance,color_lumiance);
                            color.rgb = lerp(color_saturation,color.rgb,_Saturation);

                            return color;
                        }
                        ENDCG
                    }
            }
                CustomEditor "ShaderEditorUniversal"
}

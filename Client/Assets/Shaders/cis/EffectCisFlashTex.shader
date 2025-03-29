// https://lilithgames.feishu.cn/wiki/JA1SwHJ0Vi4hEbkIGA4cCBd9nVb
//written by Maoshu
//2024.1.11

Shader "UEP/Interface/FlashTex"
{
    Properties
    {
        [Header(Main)]
        [Toggle]_ShowMainTex("_ShowMainTex(是否显示主图颜色)", int) = 1
        [Toggle]_FlashColorMode("_FlashColorMode(使用主图颜色作为闪烁颜色)",float) = 0
        _MainTex("_MainTex(主贴图)", 2D) = "white" {}
        _FlashTex("_FlashTex(闪烁图)", 2D) = "white" {}
        [HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)

        [Header(Flash)]
        [HDR]_FlashColor("_FlashColor(闪烁颜色)",Color) = (1,1,1,1)
        _TimeSpeed("_TimeSpeed(时间速度)",float) = 1
        _TimeOffset("_TimeOffset(时间偏移)",float) = 0
        _SpaceTime("_SpaceTime(时间间隔)",float) = 2
        _FlashRange("_FlashRange(闪烁块区间)",float) = 0.1
        _FlashSmooth("_FlashSmooth(闪烁块淡入淡出)",float) = 0.1

        [Header(Setting)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

        [Header(Clip)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [HideInInspector]_ColorMask("Color Mask", Float) = 15

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
            Name "FlashTex"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
			#pragma shader_feature_local __ UEP_VARIANT_1					// 要不要主图

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
                float2 texcoord  : TEXCOORD0;		
                float4 rectmask :  TEXCOORD1;
            };

            sampler2D _MainTex, _FlashTex;
            float4 _ClipRect, _MainTex_ST, _FlashTex_ST;
            half4 _MainColor, _FlashColor;
            float _TimeSpeed, _TimeOffset, _SpaceTime;
            half _FlashRange, _FlashSmooth, _FlashColorMode,_ShowMainTex;
            half _AlphaClipThreshold, _UIMaskSoftnessX, _UIMaskSoftnessY;

            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.vertex = UnityObjectToClipPos(v.vertex);

                OUT.texcoord.xy = v.texcoord;

                OUT.color = v.color;

                OUT.rectmask = 1;

                #ifdef UNITY_UI_CLIP_RECT
                float2 pixelSize = UnityObjectToClipPos(v.vertex).w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                OUT.rectmask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
                #endif

                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                half4 color = 1;

                // 遮罩
                #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
                    color.a *= m.x * m.y;
                #endif
                clip(color.a - _AlphaClipThreshold);

                //闪烁图采样
                half4 flash_tex = tex2D(_FlashTex, IN.texcoord.xy * _FlashTex_ST.xy + _FlashTex_ST.zw);
                half flashTex = 1 - flash_tex.r;

                // 主图(颜色图)采样
                half4 colorTex = tex2D(_MainTex, IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw);
                
                //分离当前闪烁块
                float mTime = fmod(_Time.y * _TimeSpeed + _TimeOffset, _SpaceTime);
                half flash1 = smoothstep(mTime + _FlashRange + _FlashSmooth, mTime + _FlashRange, flashTex);
                half flash2 = smoothstep(mTime - _FlashRange - _FlashSmooth, mTime - _FlashRange, flashTex);
                half flashFinal = flash1 * flash2 * flash_tex.a ;

                half4 flashColor = lerp(_FlashColor, colorTex * _FlashColor, _FlashColorMode);
                color *= colorTex * _MainColor;
                //颜色显示模式，_ShowMainTex = 1是显示主图颜色，_ShowMainTex = 0 时不显示主图颜色
                color.rgb = color.rgb * _ShowMainTex + flashFinal * flashColor.rgb;



                // 透明裁切
                #ifdef UNITY_UI_ALPHACLIP
                    clip(color.a - _AlphaClipThreshold);
                #endif

                return color * IN.color;
            }

            ENDCG
        }
    }
    CustomEditor "ShaderEditorUniversal"
}

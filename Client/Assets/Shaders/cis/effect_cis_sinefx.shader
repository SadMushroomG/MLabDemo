// https://lilithgames.feishu.cn/wiki/DJ3Ewpgz6i41yhk91ABcRzMcngb
// 增加控制整体颜色的参数
// Write by MaoShu
Shader "UEP/Interface/SinEfx_1"
{
    Properties
    {
        [HideInInspector]_MainTex("MainTex",2D) = "white" {}
        [Toggle(UEP_VARIANT_3)]_UseMainTex("用主图代替细节线贴图",float) = 0
        [Toggle]_UseColor("Use Color Animate",float) = 1
        [Toggle(UEP_VARIANT_1)]_UseBg("使用背景图",float) = 1
        _AniTime("播放时间",range(0,1)) = 0
        _Mask("RGB图", 2D) = "white" {}
        _LinesTex("细节线贴图",2D) = "black"{}
        [Toggle(UEP_VARIANT_2)]_LinesToMask("细节图作为遮罩",float) = 0
        _BgTex("背景图",2D) = "white" {}
        [Toggle]_BgUVChange("背景图不使用世界uv",int) = 0
        _MainSpeedX("背景图X轴移动速度",float) = 0
        _MainSpeedY("背景图Y轴移动速度",float) = 0
        _MainColor("整体颜色",Color) = (1,1,1,1)
        _BgColor("线颜色",Color) = (1,1,1,1)
        _LineSpd("线移动速度",float) = 0.5
        _LineY("线宽度",Range(0.1,4)) = 0.1
        _LineVOffset("线位置偏移",Range(-3,3)) = 0
        _WaveSize("Sin波数量",range(1,10))= 1
        _WaveEffect("波强度",range(0,1)) = 0.2
        _SinOffset("Sin位置偏移",range(0,6.28318530718)) = 0
        _Seq("Sin波速度",float) = 1
        _StencilClipRange("_StencilClipRange",range(0.001,1)) = 0.001
        //====================

        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", int) = 8
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("_Cull", int) = 2

        [Space]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10

        [HideInInspector]_ColorMask ("Color Mask", Float) = 15

        [HideInInspector][Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
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

        ZWrite Off
        ZTest [_ZTest]

        Blend [_SrcBlend] [_DstBlend]

        ColorMask [_ColorMask]
        Cull [_Cull]
        
        Pass
        {
            Name "Default"
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP
            #pragma shader_feature_local __ UEP_VARIANT_1       //是否使用背景图
            #pragma shader_feature_local __ UEP_VARIANT_2       //细节图作为遮罩
            #pragma shader_feature_local __ UEP_VARIANT_3       //用主图代替细节线贴图

            //#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            sampler2D _MainTex,_Mask,_LinesTex,_BgTex;
            float4 _BgTex_ST, _ClipRect;
                half4 _BgColor,_MainColor;
                float _LineY, _LineVOffset, _LineSpd, _Seq;
                half _UseColor, _WaveSize, _WaveEffect, _AniTime,_SinOffset, _StencilClipRange;
            float _UIMaskSoftnessX, _UIMaskSoftnessY, _MainSpeedX, _MainSpeedY,_BgUVChange;

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv: TEXCOORD0;
                half4 color: COLOR;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                float4 uv :TEXCOORD0;
                half4 color: TEXCOORD2;
                half4  mask : TEXCOORD3;
            };

            v2f vert(appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.uv;
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                if(_BgUVChange)
                {
                    o.uv.zw = v.uv * _BgTex_ST.xy + _BgTex_ST.zw;
                }
                else
                {
                    o.uv.zw = worldPos  * _BgTex_ST.xy + _BgTex_ST.zw;
                }

                o.color = v.color;
                o.mask = 1;

                #ifdef UNITY_UI_CLIP_RECT
                    float2 pixelSize = o.vertex.w;
                    pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
                    float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                    o.mask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
                #endif

                return o;
            }

            half4 frag(v2f i) : SV_Target
            {
                half4 color = 1;


                 //_Mask.r : 修正sin波对线条的哪些区域造成影响的，颜色越黑Sin波强度越小
                 //_Mask.g : 线条的最终弯曲度，颜色越黑线条最高点越低
                half3 maskVal = tex2D(_Mask, i.uv).xyz;

                //_UseColor 开启时使用Color.r控制进度
                _AniTime = lerp(_AniTime, i.color.r, _UseColor) ;

                //计算动画时间的比率
                half rate = 1 - _AniTime;
                rate = rate * rate * (3 - 2 * rate);

                //绘制sin
                half sinCurve = rate * maskVal.x * _WaveEffect * sin(_AniTime * _Seq + _SinOffset - i.uv.x*_WaveSize);
                sinCurve = sinCurve + maskVal.y;
                sinCurve = i.uv.y - sinCurve;
                sinCurve = (sinCurve - 0.5) * (_LineY + maskVal.z * 0.5) + 0.5 +  _LineVOffset; //控制UV坐标Y的偏移


                float2 lineTexUV = float2(i.uv.x, saturate(sinCurve));
                half4 lineBorder = 1;
                #ifdef UEP_VARIANT_3
                    lineBorder = tex2D(_MainTex, lineTexUV);
                #else
                    lineBorder = tex2D(_LinesTex, lineTexUV);
                #endif

                #ifdef UEP_VARIANT_1
                float2 bgUV = i.uv.zw + float2(_MainSpeedX, _MainSpeedY) * _Time.x;
                half3 bgCol = tex2D(_BgTex, bgUV).xyz * _BgColor.xyz;
                    #ifdef UEP_VARIANT_2
                    color.xyz = bgCol;
                    color.a = lineBorder.a;
                    #else
                    half bgMask = smoothstep(0.5, 1, lineBorder.w);
                    lineBorder.w = saturate(lineBorder.w * 2);
                    color.xyz = lerp(lineBorder.xyz, bgCol, bgMask);
                    color.a = lineBorder.w * i.color.a;
                    #endif
                #else
                color = lineBorder;
                #endif
                clip(color.a - _StencilClipRange);

                #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(i.mask.xy)) * i.mask.zw);
                    color.a *= m.x * m.y;
                #endif
                color *= _MainColor;
                color.a *= i.color.a;

                return color;
            }
            ENDCG 
        }
    }
    CustomEditor "ShaderEditorUniversal"
}

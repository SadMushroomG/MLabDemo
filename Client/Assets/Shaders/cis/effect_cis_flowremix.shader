// https://lilithgames.feishu.cn/wiki/wikcnCMbERmhy9dnmIjhpFK8l4d
//Ver 2.0 清理Keyword
Shader "UEP/Interface/FlowRemix"
{
    Properties
    {
        [Header(Main)][Space(5)]
        [Toggle(UEP_VARIANT_4)] _UseMainTex("_NoMainTex",float) = 0
        _MainTex ("_MainTex", 2D) = "white" {}
        [Range(0,1)]_MainRotate("_MainRotate", float) = 0
        _MainTime("_MainTime",float) = 1
        _MainSpeedX("_MainSpeedX",float) = 0
        _MainSpeedY("_MainSpeedY",float) = 0
        _BgColor("_BgColor",color) = (1,1,1,1)
        _BgDarkColor("_BgDarkColor",color) = (1,1,1,1)

        [Header(Line)][Space(5)]
        _LineTex("_LineTex", 2D) = "black" {}
        [Header(RLine)][Space(5)]
        _RColorTex("_RColorTex", 2D) = "white" {}
        _RLineColor("_RLineColor",color) = (1,1,1,1)
        _RColorRotate("_RColorRotate",float) = 0
        [Header(GLine)][Space(5)]
        [Toggle(UEP_VARIANT_2)]_GLineToggle("_GLineToggle",float) = 0
        _GLineColor("_GLineColor",color) = (1,1,1,1)
        _GColorTex("_GColorTex", 2D) = "white" {}
        _GColorRotate("_GColorRotate",float) = 0

        [Header(BLine)][Space(5)]
        [Toggle(UEP_VARIANT_3)]_BLineToggle("_BLineToggle",float) = 0
        _BLineColor("_BLineColor",color) = (1,1,1,1)
        _BColorTex("_BColorTex", 2D) = "white" {}
        _BColorRotate("_BColorRotate",float) = 0

        [Toggle]_ScreenUVToggle("_ScreenUVToggle",float) = 0
        _ScreenUVScale("_ScreenUVScale",range(0.001,2)) = 1

        [Header(Noise)][Space(5)]
        [Toggle(UEP_VARIANT_5)]_UseNoise("_UseNoise",float) = 0
        _NoiseTex("_NoiseTex", 2D) = "black" {}
        _NoisePower("_NoisePower",float) = 0

        [Header(Setting)][Space(5)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("_ZWrite", int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("_ZTest", int) = 0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("_Cull", int) = 2

        [Header(Clip)][Space(5)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [Header(Stencil)][Space(5)]
        _Stencil("_Stencil", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("_StencilComp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("_StencilOp", Float) = 0

    }
    SubShader
    {
        Tags
        { 
            "Queue" = "Transparent"
            "RenderType" = "Transparent"
            "PreviewType" = "Plane"
        }

        Stencil
        {
            Ref[_Stencil]
            Comp[_StencilComp]
            Pass[_StencilOp]
        }

        Cull [_Cull]
        ZWrite[_ZWrite]
        ZTest[_ZTest]
        Blend[_SrcBlend][_DstBlend]

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

            #pragma shader_feature_local __ UEP_VARIANT_2					// 二层Line
            #pragma shader_feature_local __ UEP_VARIANT_3					// 三层Line 
            #pragma shader_feature_local __ UEP_VARIANT_4					// MainTex
            #pragma shader_feature_local __ UEP_VARIANT_5					// Noise
            #pragma enable_d3d11_debug_symbols

            struct appdata
            {
                float4 vertex : POSITION;
                half4 color : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                half4 color : COLOR;
                float4 texcoord0 : TEXCOORD0;
                float4 rectmask : TEXCOORD1;
                float2 screenUV : TEXCOORD2;
            };

            sampler2D _RColorTex, _GColorTex, _BColorTex;
            float4 _RColorTex_ST, _GColorTex_ST, _BColorTex_ST;

            #ifdef UEP_VARIANT_5
                sampler2D _NoiseTex;
                float4 _NoiseTex_ST;
                half _NoisePower;
            #endif

            sampler2D _MainTex,_LineTex;
            float4 _ClipRect,_MainTex_ST,_LineTex_ST;
            half4 _BgColor,_BgDarkColor, _RLineColor, _GLineColor, _BLineColor;
            float _MainSpeedX, _MainSpeedY, _MainRotate, _MainTime,_RColorRotate,_GColorRotate,_BColorRotate;
            float _UIMaskSoftnessX, _UIMaskSoftnessY,_ScreenUVScale;
            half _UseMainTex,_AlphaClipThreshold,_ScreenUVToggle;


            float2 Unity_Rotate_Radians_float(float2 UV, float Rotation)
            {
                if (Rotation != 0)
                {
                    UV -= 0.5;
                    float s = sin(Rotation);
                    float c = cos(Rotation);
                    float2x2 rMatrix = float2x2(c, -s, s, c);
                    UV.xy = mul(UV.xy, rMatrix);
                    UV += 0.5;
                }
                return UV;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.color = v.color;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord0.xy = v.vertex.xy;
                o.texcoord0.zw= v.texcoord;
                o.rectmask = 1;
                #ifdef UNITY_UI_CLIP_RECT
                    float2 pixelSize = UnityObjectToClipPos(v.vertex).w;
                    pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
                    float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                    o.rectmask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
                #endif

                o.screenUV = 1;
                if(_ScreenUVToggle)
                {
                    float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    o.screenUV = worldPos * _ScreenUVScale;
                }
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {

                float2 uv = i.texcoord0.zw;
                _Time.x *= _MainTime;

                half4 col = half4(0, 0, 0, 0);

                #ifdef UEP_VARIANT_4
                    float2 mainUV = Unity_Rotate_Radians_float(uv, _MainRotate);
                    mainUV = mainUV * _MainTex_ST.xy + _MainTex_ST.zw + float2(_MainSpeedX, _MainSpeedY) * _Time.x;

                    col = tex2D(_MainTex, mainUV) * _BgColor;
                #endif

                half alpha = col.a;
                float noise = 0;

                #ifdef UEP_VARIANT_5
                    noise = (tex2D(_NoiseTex, uv * _NoiseTex_ST.xy + _NoiseTex_ST.zw*_Time.x).x  - 0.5)* _NoisePower*0.1;
                #endif

                float2 LineUV = uv * _LineTex_ST.xy + _LineTex_ST.zw * _Time.x + noise;
                half4 LineMask = (0, 0, 0, 0);
                half LineAlpha = 0;

                LineMask = tex2D(_LineTex, LineUV);
                LineAlpha += LineMask.r;

                #ifdef UEP_VARIANT_2
                    LineAlpha += LineMask.g;
                #endif

                #ifdef UEP_VARIANT_3
                    LineAlpha += LineMask.b;
                #endif

                //颜色
                half4 RLineColor = _RLineColor;
                half4 GLineColor = _GLineColor;
                half4 BLineColor = _BLineColor;

                float2 Ruv = uv;
                float2 Guv = uv;
                float2 Buv = uv;
                if(_ScreenUVToggle)
                {
                    Ruv =  i.screenUV;
                    Guv =  i.screenUV;
                    Buv =  i.screenUV;
                }
                Ruv = Unity_Rotate_Radians_float(Ruv, _RColorRotate);
                Guv = Unity_Rotate_Radians_float(Guv, _GColorRotate);
                Buv = Unity_Rotate_Radians_float(Buv, _BColorRotate);

                float2 RColorUV = Ruv * _RColorTex_ST.xy + _RColorTex_ST.zw * _Time.x + noise;
                float2 GColorUV = Guv * _GColorTex_ST.xy + _GColorTex_ST.zw * _Time.x + noise;
                float2 BColorUV = Buv * _BColorTex_ST.xy + _BColorTex_ST.zw * _Time.x + noise;

                RLineColor = tex2D(_RColorTex, RColorUV) * _RLineColor;
                GLineColor = tex2D(_GColorTex, GColorUV) * _GLineColor;
                BLineColor = tex2D(_BColorTex, BColorUV) * _BLineColor;

                
                #ifdef UEP_VARIANT_4
                    col = lerp(col, RLineColor, LineMask.r * _RLineColor.w);
                #else
                    col.xyz = RLineColor;
                    col.w = LineMask.r * _RLineColor.w;
                #endif

                #ifdef UEP_VARIANT_2
                    col = lerp(col, GLineColor, LineMask.g * _GLineColor.w);
                #endif

                #ifdef UEP_VARIANT_3
                    col = lerp(col, BLineColor, LineMask.b * _BLineColor.w);    
                #endif

                col.a = alpha * _UseMainTex + col.a * saturate(LineAlpha) - col.a * _UseMainTex* saturate(LineAlpha);
                col = lerp(col * _BgDarkColor, col, LineMask.a);

                #ifdef UNITY_UI_ALPHACLIP
                    clip(col.a - _AlphaClipThreshold);
                #endif

                #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(i.rectmask.xy)) * i.rectmask.zw);
                    col.a *= m.x * m.y;
                #endif

                return col * i.color;
            }
            ENDCG
        }
    }
    CustomEditor "EffectUEPFlowRemix"
}

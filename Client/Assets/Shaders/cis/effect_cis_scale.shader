// https://lilithgames.feishu.cn/wiki/B0N3wCm2NicNBPkkdf2ctG4QnYe
// Write By Maoshu
// UI Scale Effect
Shader "UEP/Interface/SimpleScale"
{
    Properties
    {
        _MainTex("_MainTex(主贴图)", 2D) = "white" {}
        [HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)
        _UVTiling("_ScaleValue(UV大小)",float) = 1

        [KeywordEnum(Type1, Type2)]_ScaleType("缩放曲线模式", Float) = 0
        _SpeedOffset("偏差值",float) = 0
        _AlphaMin("_AlphaMin",float) = 0
        _AlphaRange("_AlphaRange",float) = 10

        [Header(Scale)][Space(10)]
        _TimeSpeed("_TimeSpeed(缩放速度)",float) = 1
        _Scale("_Scale(缩放大小)",float) = 1
        _Power("_Power(缩放强度)",float) = 10
        _MinScale("_MinScale(最小缩放大小)",Range(0, 1)) = 0.5
        _PeriodOffset("_PeriodOffset(周期偏移)", Range(0, 1)) = 0

        [Header(Setting)][Space(10)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10

        [Header(Clip)][Space(10)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [Header(Stencil)][Space(10)]
        _Stencil("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("Stencil Operation", Float) = 0
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
            }

            ZWrite Off
            ZTest Always
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
                #pragma shader_feature_local __ UEP_VARIANT_1					//使用预设曲线
                #pragma shader_feature_local __ UEP_VARIANT_2					//使用预设曲线2
                #pragma shader_feature_local __ UEP_VARIANT_3					//使用颜色值做偏差

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
                    float4 worldPosition : TEXCOORD1;
                    half4  mask : TEXCOORD2;
                };

                sampler2D _MainTex;
                float4 _MainTex_ST;
                half4 _MainColor, _ClipRect;
                float _UIMaskSoftnessX, _UIMaskSoftnessY, _TimeSpeed,_Scale,_Power, _MinScale, _PeriodOffset,_UVTiling;
                half _AlphaClipThreshold,_ColorBlend, _AlphaMin, _AlphaRange;

                float OutElastic(float x,float t,float s)
                {
                    float sin1 = (sin(x * 5) + sin(x * 10)) / t + s;
                    return sin1;
                }
                float OutCirc(float x)
                {
                    float result = sqrt(1 - pow((x - 1), 2));
                    return result;
                }

                float OutSin(float x)
                {
                   return sin(x * 1.571);
                }

                float OutAlpha(float x)
                {
                    return min(4 * x, 0.7 - 0.67 * x);
                
                }
                v2f vert(appdata_t v)
                {
                    v2f OUT;

                    float4 vPosition = UnityObjectToClipPos(v.vertex);
                    OUT.worldPosition = v.vertex;
                    OUT.vertex = vPosition;

                    float2 pixelSize = vPosition.w;
                    pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));

                    float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                    float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                    OUT.texcoord = float4(v.texcoord.x, v.texcoord.y, maskUV.x, maskUV.y);
                    OUT.mask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
                    OUT.color = v.color;

                    return OUT;
                }

                fixed4 frag(v2f IN) : SV_Target
                {
                    // 遮罩
                    half4 color = 1;

                    #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                    color.a *= m.x * m.y;
                    #endif

                    float2 sinUV = IN.texcoord * _UVTiling - (_UVTiling-1)/2;
                    float sinScale = _MainTex_ST.x;
                    float sinOffset = _MainTex_ST.z;
                    #ifdef UEP_VARIANT_3
                    _Time.y += IN.color.x;
                    #endif      

                    #ifdef UEP_VARIANT_1
                        sinScale = OutElastic(_Time.y * _TimeSpeed, _Power, _Scale);
                        sinOffset = (1 - sinScale) / 2;
                        sinUV = float2(sinScale, sinScale) * IN.texcoord + float2(sinOffset, sinOffset);

                        smoothstep(1.5, 1, sinScale);
                        color.a*= smoothstep( _AlphaMin  + _AlphaRange, _AlphaMin,sinScale);
                    #endif      

                    #ifdef UEP_VARIANT_2
                        //To get a period time func from 0 to 1
                        float time = frac(_Time.y * _TimeSpeed + _PeriodOffset);

                        sinScale = OutSin(time) * (1 - _MinScale) + _MinScale;
                        sinScale = 1 / sinScale;
                        sinOffset = (1 - sinScale) / 2;
                        sinUV = float2(sinScale, sinScale) * IN.texcoord + float2(sinOffset, sinOffset);
                    
                        color.a = OutAlpha(time);
                    #endif

                    #ifdef UEP_VARIANT_3
                        color *= (tex2D(_MainTex, sinUV));
                        color.a *=  IN.color.a;
                    #else                 
                        color *= (tex2D(_MainTex, sinUV)) * IN.color;
                    #endif      

                    #ifdef UNITY_UI_ALPHACLIP
                    clip(color.a - 0.001);
                    #endif 

                    return color* _MainColor;
                }
                ENDCG
            }
        }
            CustomEditor "ScaleShaderGUI"
}

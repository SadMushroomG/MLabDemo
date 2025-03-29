// https://lilithgames.feishu.cn/wiki/wikcnLCAMf8KTEOm9qVpZZuK5lf?from=from_copylink
// 根据现在所使用的工作做的定向优化，并增加了LOD
// Write by Maoshu
Shader "UEP/Interface/ScreenUVTex"
{
    Properties
    {
        [Toggle(UEP_VARIANT_1)] _IsSliced("_IsSliced(九宫格)",int) = 0
        _MainTex("_MainTex(主贴图)",2D) = "white" {}
        _ColorTex("_ColorTex(颜色贴图)",2D) = "white" {}
        _ScreenUV("_ScreenUV(平铺图Tiling)",vector) = (1,1,0,0)
        _MainColor("_MainColor(颜色贴图)",color) = (1,1,1,1)
        _MainSpeedX("_MainSpeedX(X轴移动速度)",float) = 0
        _MainSpeedY("_MainSpeedY(Y轴移动速度)",float) = 0
        [Space(20)]
        [Toggle(UNITY_UI_ALPHACLIP)]_AlphaClip("_AlphaClip(使用裁切)",int) =0
        _AlphaClipThreshold("_AlphaClipThreshold(裁切范围)",range(0,1)) = 0.001
        [Space(20)]
        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255
        [Space(20)]
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", int) = 8
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2


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
        Cull [_Cull]

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
            #pragma shader_feature_local __ UEP_VARIANT_1       //是否为九宫格



            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv : TEXCOORD0;
                half4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex  : SV_POSITION;
                float4 uv :TEXCOORD0;
                half4  mask : TEXCOORD1;
                half4 color : COLOR;
            };

            sampler2D _MainTex,_ColorTex;
            float4 _ClipRect, _ScreenUV;
            half4 _MainColor;
            float _UIMaskSoftnessX, _UIMaskSoftnessY, _MainSpeedX, _MainSpeedY;
            half _AlphaClipThreshold;


            v2f vert(appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.uv;
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.uv.zw = worldPos  * _ScreenUV.xy + _ScreenUV.zw;

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

            fixed4 frag(v2f i) : SV_Target
            {
                float2 UV = i.uv.zw + float2(_MainSpeedX,_MainSpeedY) * _Time.x;
                half4 color = _MainColor * i.color;

                #ifdef UEP_VARIANT_1
                    color.rgb *= tex2D(_ColorTex, UV).rgb;
                    color.a *= tex2D(_MainTex, i.uv).a; 
                #else
                    color *= tex2D(_MainTex, UV) ;
                #endif

                #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(i.mask.xy)) * i.mask.zw);
                    color.a *= m.x * m.y;
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                    clip(color.a - _AlphaClipThreshold);
                #endif

                return color;
            }
            ENDCG
        }
    }
}

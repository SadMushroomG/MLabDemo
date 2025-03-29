Shader "UEP/Interface/OutlinePuzzle"
{
    Properties
    {
        [Header(Main)] [Space(5)]
        _MainTex("_MainTex(主贴图)", 2D) = "white" {}
        [HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)
        _InlineColor("_InlineColor(内描边颜色)",color) = (1,1,1,1)
        _InlineRange("_InlineRange",float) = 0.99

        [Header(Outline)][Space(5)]
        _OutlineColor("_OutlineColor(描边颜色)",color) = (1,1,1,1)
        _OutlineWidth("_OutlineWidth(描边宽度)",range(0,1)) = 0.25
        _OutlineSoftness("_OutlineSoftness(描边软边范围)",float) = 0.1
        _OutlineAlpha("_OutlineAlpha(描边透明度)",range(0,1)) = 1

        [Header(Select)][Space(5)]
        [Toggle(UEP_VARIANT_1)]_IsSelect("_IsSelect(是否选中)",int) = 0
        _SelectTex_ST("_SelectTex_ST(选择图Tiling和Speed)",vector) = (1,1,0,0)
        _SelectTex1("_SelectTex1(选择图1)", 2D) = "white" {}
        _SelectTex2("_SelectTex2(选择图2)", 2D) = "white" {}
        _SelectLerp("_SelectLerp(选择图1和2过渡)",range(0,1)) = 0

        [Header(Setting)][Space(5)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

        [Header(Clip)][Space(5)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [HideInInspector]_ColorMask("Color Mask", Float) = 15

        [Header(Stencil)][Space(5)]
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
            Name "UIOutlinePuzzle"

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
            #pragma shader_feature_local __ UEP_VARIANT_1					

            struct appdata_t
            {
                float4 vertex   : POSITION;
                half4 color : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                half4 color : COLOR;
                float2 texcoord  : TEXCOORD0;		
                float4 rectmask :  TEXCOORD1;
            };

            sampler2D _MainTex, _SelectTex1, _SelectTex2;
            float4 _SelectTex_ST, _ClipRect, _MainTex_ST;
            half4 _MainColor, _InlineColor, _OutlineColor;
            float _OutlineWidth, _OutlineSoftness, _OutlineAlpha, _SelectLerp;
            half _AlphaClipThreshold, _UIMaskSoftnessX, _UIMaskSoftnessY, _InlineRange;

            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.vertex = UnityObjectToClipPos(v.vertex);

                OUT.texcoord.xy = v.texcoord;

                OUT.color = v.color * _MainColor;

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
                half4 color = IN.color;

                // UI RectMask2D
                #ifdef UNITY_UI_CLIP_RECT
                    half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
                    color.a *= m.x * m.y;
                #endif

                // 主图部分
                half4 main_tex = tex2D(_MainTex, IN.texcoord.xy);
                half main_alpha = smoothstep(0.5,1,main_tex.w);
                half3 main_color = lerp(_InlineColor , main_tex.xyz , smoothstep(_InlineRange,1, main_tex.w));

                // 描边部分
                half outline_width = 1 - _OutlineWidth;
                half outline_range = smoothstep(outline_width, outline_width+ _OutlineSoftness, saturate(main_tex.w * 2));
                half outline_color_mask = (1 - main_alpha) * _OutlineAlpha;
                half3 outline_color = lerp(main_color, _OutlineColor,  outline_color_mask);
                half outline_alpha = saturate(main_alpha + outline_range*_OutlineAlpha);

                #ifdef UEP_VARIANT_1
                    // 选择部分
                    float2 select_uv = IN.texcoord.xy * _SelectTex_ST.xy + _SelectTex_ST.zw * _Time.y;
                    half3 select_tex_1 = tex2D(_SelectTex1, select_uv).xyz;
                    half3 select_tex_2 = tex2D(_SelectTex2, select_uv).xyz;
                    half3 select_color_change = lerp(select_tex_1, select_tex_2, _SelectLerp);
                    half3 select_color = lerp(main_color, select_color_change, outline_color_mask);
                    color *= half4(select_color, outline_alpha);
                #else
                    color *= half4(outline_color, outline_alpha);
                #endif

                // 透明裁切
                #ifdef UNITY_UI_ALPHACLIP
                    clip(color.a - _AlphaClipThreshold);
                #endif

                return color;
            }

            ENDCG
        }
    }
    CustomEditor "ShaderEditorUniversal"
}

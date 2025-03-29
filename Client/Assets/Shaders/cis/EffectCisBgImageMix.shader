
Shader "UEP/Interface/BgAndImageMix"
{
    Properties
    {
		[Header(Main)]
        _MainTex("_MainTex(主贴图)", 2D) = "white" {}
        [HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)
        _MaskTex("_MaskTex()", 2D) = "white" {}
        [Toggle]_MaskTex_RorA("_MaskTex_RorA",float) = 0
        _BgTex("_BgTex()",2D) = "white"{}
        _BgColor("_BgColor()",Color) = (1,1,1,1)
        _BgTex_Speed_X("_BgTex_Speed_X()",float) = 0
        _BgTex_Speed_Y("_BgTex_Speed_Y()",float) = 0

		[Header(Setting)]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

		[Header(Clip)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

		[HideInInspector]_ColorMask ("Color Mask", Float) = 15
		
        [Header(Stencil)] 
        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
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
        }

        Cull [_Cull]
        ZWrite [_ZWrite]
        ZTest [_ZTest]
        Blend [_SrcBlend] [_DstBlend]
        ColorMask [_ColorMask]

        Pass
        {
            Name "BgAndImageMix"
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

            struct appdata_t
            {
                float4 vertex   : POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;		//xy:uv zw:worldPosition
                float4 rectmask :  TEXCOORD1;
            };

            sampler2D _MainTex,_MaskTex,_BgTex;
		    float4 _MainTex_ST,_MaskTex_ST,_BgTex_ST;
		    half4 _MainColor,_BgColor,_ClipRect;
            float _BgTex_Speed_X,_BgTex_Speed_Y;
			half _AlphaClipThreshold,_UIMaskSoftnessX, _UIMaskSoftnessY,_MaskTex_RorA;


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
                half4 color_f = IN.color;
				// 遮罩
                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
                color_f.a *= m.x * m.y;
                #endif

				// 采样
                float2 main_uv =  IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                half4 main_tex = tex2D(_MainTex, main_uv) * _MainColor;
                float2 mask_uv = IN.texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
                half4 mask_tex = tex2D(_MaskTex, mask_uv);
                half mask_f = lerp(mask_tex.a,mask_tex.r,_MaskTex_RorA);
                float2 bg_uv = IN.texcoord.xy * _BgTex_ST.xy + _BgTex_ST.zw + float2(_BgTex_Speed_X,_BgTex_Speed_Y)*_Time.y;
                half4 bg_tex =  tex2D(_BgTex, bg_uv) * _BgColor;
                
                //混合
                color_f.rgb *= lerp(bg_tex.rgb,main_tex.rgb,main_tex.a * _MainColor.a);
                color_f.a *= mask_f ;
                //color_f.a *= lerp(main_tex.a * mask_f , mask_f , bg_tex.a) ;

				// 透明裁切
				#ifdef UNITY_UI_ALPHACLIP
                    clip(color_f.a - _AlphaClipThreshold);
                #endif

                return color_f;
            }
			ENDCG
        }
    }
	CustomEditor "ShaderEditorUniversal"
}

// https://lilithgames.feishu.cn/wiki/BvPQwDJmUiRK4NkaxnJckm5mnie
// Ver 1.1 增加八方向的阴影效果

Shader "UEP/Interface/OutlineFourDir"
{
    Properties
    {
        _MainTex ("_MainTex(主贴图)", 2D) = "white" {}
        [HDR]_MainColor ("_MainColor(主图颜色)", Color) = (1,1,1,1)

		[Header(Outline)][Space()]
        [Toggle(UEP_VARIANT_1)]_EightDir("_EightDir(8方向描边)",int) = 0
        _OutlineTex ("_OutlineTex(描边贴图)", 2D) = "white" {}
        [HDR]_OutlineColor ("_OutlineColor(描边颜色)", Color) = (1,1,1,1)
        _OutlineWidth("_OutlineWidth(描边宽度)",range(0,0.05)) = 0.01
        _Outline_Speed_X("_Outline_Speed_X(描边图X轴速度)",Float) = 0
        _Outline_Speed_Y("_Outline_Speed_Y(描边图Y轴速度)",Float) = 0


		[Header(Setting)][Space()]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

		[Header(Clip)][Space()]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

		[HideInInspector]_ColorMask ("Color Mask", Float) = 15
		
        [Header(Stencil)][Space()]
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
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
            Name "UIDefaultEx"
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
			#pragma shader_feature_local __ UEP_VARIANT_1					

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
                float4 texcoord  : TEXCOORD0;		//xy:uv zw:worldPosition
                float4 rectmask :  TEXCOORD1;
            };

            sampler2D _MainTex,_OutlineTex;
		    half4 _MainColor,_OutlineColor;
		    float4 _MainTex_ST,_ClipRect,_OutlineTex_ST;
			half _AlphaClipThreshold;
            float _UIMaskSoftnessX, _UIMaskSoftnessY,_OutlineWidth,_Outline_Speed_X,_Outline_Speed_Y;


            v2f vert(appdata_t v)
            {
                v2f OUT;

                OUT.texcoord.zw = v.vertex.xy;
                OUT.vertex = UnityObjectToClipPos(v.vertex);

                OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

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
                half4 color =  IN.color;
				// 遮罩
                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
                color.a *= m.x * m.y;
                #endif

				// 贴图采样1.1倍，防止穿帮
                float2 main_uv  =  IN.texcoord.xy * 1.1 + float2(-0.05,-0.05);
                float4 color_tex = tex2D(_MainTex, main_uv) * _MainColor;

                if(color_tex.a < 0.99 &&  _OutlineWidth  > 0.001)  // icon透明部分，且有描边宽度时，才走这里
                {
                    #ifdef UEP_VARIANT_1
                    //八个方向的描边UV偏移
                    float2 outline_uv_1 = main_uv + float2(0,_OutlineWidth);
                    float2 outline_uv_2 = main_uv + float2(_OutlineWidth,0);
                    float2 outline_uv_3 = main_uv - float2(0,_OutlineWidth);
                    float2 outline_uv_4 = main_uv - float2(_OutlineWidth,0);
                    float outline_width_1 = _OutlineWidth/2;
                    float2 outline_uv_5 = main_uv + float2(outline_width_1,-outline_width_1);
                    float2 outline_uv_6 = main_uv + float2(-outline_width_1,outline_width_1);
                    float2 outline_uv_7 = main_uv - float2(outline_width_1,outline_width_1);
                    float2 outline_uv_8 = main_uv - float2(-outline_width_1,-outline_width_1);

                    //采样八个方向的主图做描边的形状
                    float mask_outline = tex2D(_MainTex,outline_uv_1).a + tex2D(_MainTex,outline_uv_2).a + tex2D(_MainTex,outline_uv_3).a + tex2D(_MainTex,outline_uv_4).a;
                    mask_outline += tex2D(_MainTex,outline_uv_5).a+ tex2D(_MainTex,outline_uv_6).a+ tex2D(_MainTex,outline_uv_7).a+ tex2D(_MainTex,outline_uv_8).a;
                    mask_outline = saturate(mask_outline);

                    #else
                    //四个方向的描边UV偏移
                    float2 outline_uv_1 = main_uv + float2(0,_OutlineWidth);
                    float2 outline_uv_2 = main_uv + float2(_OutlineWidth,0);
                    float2 outline_uv_3 = main_uv - float2(0,_OutlineWidth);
                    float2 outline_uv_4 = main_uv - float2(_OutlineWidth,0);

                    //采样四个方向的主图做描边的形状
                    float mask_outline =  tex2D(_MainTex,outline_uv_1).a + tex2D(_MainTex,outline_uv_2).a + tex2D(_MainTex,outline_uv_3).a + tex2D(_MainTex,outline_uv_4).a;
                    mask_outline = saturate(mask_outline);
                    #endif

                    //描边的颜色填充图
                    float2 outline_tex_uv = IN.texcoord.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw + float2(_Outline_Speed_X,_Outline_Speed_Y) *_Time.y;
                    float3 outline_color = tex2D(_OutlineTex,outline_tex_uv).rgb * _OutlineColor.rgb;

                    color.rgb *= lerp(outline_color * _OutlineColor.a , color_tex.rgb , color_tex.a);
                    color.a *= lerp(mask_outline * _OutlineColor.a , 1 , color_tex.a);
                }
                else
                {
                    color *= color_tex;
                }


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

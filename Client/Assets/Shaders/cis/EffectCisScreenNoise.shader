Shader "UEP/Interface/ScreenNoise"
{
	Properties
	{
		_MainTex ("_MainTex(主贴图)", 2D) = "white" {}
		[HDR]_MainColor ("_MainColor(颜色)", Color) = (1,1,1,1)
		[Header(ScreenUV)][Space()]
		_StaticUVScale("_StaticUVScale(固定比例UV大小)",range(0.0001,1)) = 0.05

		[Header(NoiseTex1)][Space()]
		_NoiseTex_1("_NoiseTex_1(噪点图1)", 2D) = "white" {}
		_NoisePower_1("_NoisePower_1(噪点图1 扰动强度)",float) = 0
		_Noise_Offset_1("_Noise_Offset_1(噪点图1 扰动偏移)",float) = 0
		_NoiseSpeed_X_1("_NoiseSpeed_X_1(噪点图1 X轴位移速度)",float) = 0
		_NoiseSpeed_Y_1("_NoiseSpeed_Y_1(噪点图1 Y轴位移速度)",float) = 0

		[Header(NoiseTex2)][Space()]
		[Toggle(UEP_VARIANT_1)]_Noise_2("_Noise_2(开启噪点图2)",float) = 0
		_NoiseTex_2("_NoiseTex_2(噪点图2)", 2D) = "white" {}
		_NoisePower_2("_NoisePower_2(噪点图2 扰动强度)",float) = 0
		_Noise_Offset_2("_Noise_Offset_2(噪点图2 扰动偏移)",float) = 0
		_NoiseSpeed_X_2("_NoiseSpeed_X_2(噪点图2 X轴位移速度)",float) = 0
		_NoiseSpeed_Y_2("_NoiseSpeed_Y_2(噪点图2 Y轴位移速度)",float) = 0

		[Header(Setting)][Space()]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
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

			sampler2D _MainTex,_NoiseTex_1,_NoiseTex_2;
			half4 _MainColor;
			float4 _MainTex_ST,_NoiseTex_1_ST,_NoiseTex_2_ST,_ClipRect;
			half _AlphaClipThreshold,_NoisePower_1,_NoisePower_2;
			float _UIMaskSoftnessX, _UIMaskSoftnessY,_StaticUVScale;
			float _Noise_Offset_1,_NoiseSpeed_X_1,_NoiseSpeed_Y_1;
			float _Noise_Offset_2,_NoiseSpeed_X_2,_NoiseSpeed_Y_2;


			v2f vert(appdata_t v)
			{
				v2f OUT;

				OUT.texcoord.zw = v.vertex.xy;
				OUT.vertex = UnityObjectToClipPos(v.vertex);

				//主图uv
				OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				//噪点图uv（世界坐标uv）
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				OUT.texcoord.zw = worldPos * _StaticUVScale;

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
				half4 color = 1;
				// 遮罩
				#ifdef UNITY_UI_CLIP_RECT
				half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
				color.a *= m.x * m.y;
				#endif

				//噪点图采样
				float2 noise_uv_1 = IN.texcoord.zw * _NoiseTex_1_ST.xy + _NoiseTex_1_ST.zw + float2(_NoiseSpeed_X_1,_NoiseSpeed_Y_1) * _Time.y;
				float noise_tex_1 = tex2D(_NoiseTex_1,noise_uv_1).r * _NoisePower_1 - _Noise_Offset_1;
				float2 main_uv = IN.texcoord.xy + noise_tex_1;

				#ifdef UEP_VARIANT_1
				float2 noise_uv_2 = IN.texcoord.zw * _NoiseTex_2_ST.xy + _NoiseTex_2_ST.zw + float2(_NoiseSpeed_X_2,_NoiseSpeed_Y_2) * _Time.y;
				float noise_tex_2 = tex2D(_NoiseTex_2,noise_uv_2).r * _NoisePower_2 - _Noise_Offset_2;
				main_uv += noise_tex_2;
				#endif

				// 贴图采样
				color *= tex2D(_MainTex , main_uv);
				color *= IN.color;
				//color = float4(noise_tex_1 + noise_tex_2,noise_tex_1 + noise_tex_2,noise_tex_1 + noise_tex_2,1);

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

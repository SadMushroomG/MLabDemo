// https://lilithgames.feishu.cn/wiki/E6iDwRdHAiDjUSkLY3mcopuvnAf
// 2025.02.20
// write by Maoshu
// UI Super Fast Gaussian Blur（只有4次采样的简陋版高斯模糊）

Shader "UEP/Interface/FastGaussainBlur"
{
	Properties
	{
		_MainTex ("_MainTex(主贴图)", 2D) = "white" {}
		[HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)
		[Toggle(UEP_VARIANT_1)]_UseBlur("_UseBlur(是否开启模糊效果)", int) = 0
		_BlurStrength("_BlurStrength(模糊强度)", Range(0, 5)) = 1

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
		[HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
		[HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255
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
			#pragma shader_feature_local __ UEP_VARIANT_1 //是否开启模糊效果

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

			sampler2D _MainTex;
			half4 _MainColor;
			float4 _MainTex_ST,_ClipRect,_MainTex_TexelSize;
			half _AlphaClipThreshold;
			float _UIMaskSoftnessX, _UIMaskSoftnessY,_BlurStrength;

			v2f vert(appdata_t v)
			{
				v2f OUT;

				OUT.texcoord.zw = v.vertex.xy;
				OUT.vertex = UnityObjectToClipPos(v.vertex);

				OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

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

				// 贴图采样
				#ifdef UEP_VARIANT_1
					float2 delta = _MainTex_TexelSize.xy * _BlurStrength;
					// 4个对角采样点
					float2 uv1 = IN.texcoord.xy + float2(-0.707 * delta.x, -0.707 * delta.y); // 左下
					float2 uv2 = IN.texcoord.xy + float2( 0.707 * delta.x, -0.707 * delta.y); // 右下
					float2 uv3 = IN.texcoord.xy + float2(-0.707 * delta.x, 0.707 * delta.y); // 左上
					float2 uv4 = IN.texcoord.xy + float2( 0.707 * delta.x, 0.707 * delta.y); // 右上
					// 加权平均（模拟高斯分布）
					color *=
						tex2D(_MainTex, uv1) * 0.25 +
						tex2D(_MainTex, uv2) * 0.25 +
						tex2D(_MainTex, uv3) * 0.25 +
						tex2D(_MainTex, uv4) * 0.25 ;
				#else
					color *= tex2D(_MainTex, IN.texcoord.xy);
				#endif

				color *= IN.color;

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

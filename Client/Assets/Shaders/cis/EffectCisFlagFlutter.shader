// https://lilithgames.feishu.cn/wiki/HZ8EwPFO4iGb7ckaXvicAJKNnXf
// 2025.02.01
// write by Maoshu
// UV动画版 旗帜飘动效果

Shader "UEP/Interface/FlagFlutter"
{
	Properties
	{
		_MainTex("_MainTex(主贴图)", 2D) = "white" {}
		[HDR]_MainColor("_MainColor(颜色)", Color) = (1,1,1,1)
		[Header(Main)][Space()]
		[Toggle(UEP_VARIANT_1)]_UseTexture("_UseTexture()",Float) = 0
		_FlutterTex("_FlutterTex(飘动)", 2D) = "white"{}
		_TimeScale("_TimeScale()", Float) = -5
		_FlutterMumber("_FlutterMumber()", Float) = 12
		_FlutterPower("_FlutterPower()", range(0,1)) = 0.05
		_FlutterRotate("_FlutterRotate()", Float) = 0.5

		[Header(Detail)][Space()]
		_MaskTex("_MaskTex()", 2D) = "white"{}
		_NoiseTex("_NoiseTex()", 2D) = "black"{}
		_NoisePower("_NoisePower()", range(0,1)) = 0
		_ShadowColor("_ShadowColor()", Color) = (0,0,0,0)
		_ShadowPower("_ShadowPower()", range(0,1)) = 0.5

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

			// #pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			#pragma shader_feature_local __ UEP_VARIANT_1
			//#pragma shader_feature_local __ UEP_VARIANT_2

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
				float4 texcoord2  : TEXCOORD1;		
				// float4 rectmask :  TEXCOORD1;
			};

			sampler2D _MainTex,_FlutterTex,_MaskTex,_NoiseTex;
			half4 _MainColor,_ShadowColor;
			float4 _MainTex_ST,_NoiseTex_ST;
			half _AlphaClipThreshold,_ShadowPower;
			float _TimeScale,_FlutterRotate,_FlutterPower,_NoisePower,_FlutterMumber;

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

			v2f vert(appdata_t v)
			{
				v2f OUT;

				OUT.texcoord.zw = v.vertex.xy;
				OUT.vertex = UnityObjectToClipPos(v.vertex);

				OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				OUT.texcoord2.xy = TRANSFORM_TEX(v.texcoord, _NoiseTex);
				OUT.texcoord2.zw = v.texcoord;

				OUT.color = v.color * _MainColor;

				// OUT.rectmask = 1;

				// #ifdef UNITY_UI_CLIP_RECT
				// float2 pixelSize = UnityObjectToClipPos(v.vertex).w;
				// pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
				// float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
				// OUT.rectmask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
				// #endif

				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				half4 color = 1;
				float2 uv = IN.texcoord2.zw; // 原始UV
				// 遮罩
				// #ifdef UNITY_UI_CLIP_RECT
				// half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
				// color.a *= m.x * m.y;
				// #endif

				// UV飘动效果
				float2 flutter_UV = Unity_Rotate_Radians_float(uv,_FlutterRotate);
				flutter_UV = flutter_UV * float2(_FlutterMumber,1) + float2(_Time.y * _TimeScale,0);
				float flutter_mask = 0;
				#ifdef UEP_VARIANT_1
					flutter_mask = tex2D(_FlutterTex,flutter_UV).r;
				#else
					flutter_mask = sin(flutter_UV.x);
				#endif

				// 飘动增加细节及遮罩
				float noise = tex2D(_NoiseTex, IN.texcoord2.xy).r * _NoisePower;
				float mask = tex2D(_MaskTex,uv).r;

				flutter_mask += noise - 0.5;
				flutter_mask *= mask;

				// 贴图采样
				float flutter_power = flutter_mask * _FlutterPower;

				float2 main_uv = IN.texcoord.xy * (flutter_power + 1) - (flutter_power * 0.5);
				color *= tex2D(_MainTex, main_uv);
				color.rgb = lerp(color,_ShadowColor,flutter_mask*_ShadowPower); 

				// 透明裁切
				#ifdef UNITY_UI_ALPHACLIP
				clip(color.a - _AlphaClipThreshold);
				#endif

				return color *= IN.color;
			}
			ENDCG
		}
	}
	CustomEditor "ShaderEditorUniversal"
}

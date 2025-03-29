// https://lilithgames.feishu.cn/wiki/L9qvw1OxKicj8Akv5uzcAxiInud
// 2025.03.04
// write by Maoshu
// 万花筒效果

Shader "UEP/Interface/Kaleidoscope"
{
	Properties
	{
		_MainTex ("_MainTex(主贴图)", 2D) = "white" {}
		[HDR]_MainColor ("_MainColor(颜色)", Color) = (1,1,1,1)
		
		[Header(Main)][Space()]
		_Scale("_Scale(万花筒大小)",Float) = 6
		_Rotate("_Rotate(旋转角度)",Float) = 0
		_Amount("_Amount(万花筒数量)",Float) = 6
		_TimeScale("_TimeScale(时间速率)",Float) = 0.1
		_Offset_X("_Offset_X(横向偏移)",Range(-1,1)) = 0
		_Offset_Y("_Offset_Y(纵向偏移)",Range(-1,1)) = 0

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
			//#pragma shader_feature_local __ UEP_VARIANT_1
			//#pragma shader_feature_local __ UEP_VARIANT_2

			struct appdata_t
			{
				float4 vertex   : POSITION;
				half4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				half4 color    : COLOR;
				float4 texcoord  : TEXCOORD0;		//xy:uv zw:worldPosition
				float4 rectmask :  TEXCOORD1;
			};

			sampler2D _MainTex;
			half4 _MainColor;
			float4 _MainTex_ST,_ClipRect;
			half _AlphaClipThreshold,_UIMaskSoftnessX,_UIMaskSoftnessY;
			float _Scale,_Rotate,_Amount,_TimeScale,_Offset_X,_Offset_Y;

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

			half4 frag(v2f IN) : SV_Target
			{
				half4 color = IN.color;
				// 遮罩
				#ifdef UNITY_UI_CLIP_RECT
					half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.rectmask.xy)) * IN.rectmask.zw);
					color.a *= m.x * m.y;
				#endif
				
				float2 uv = IN.texcoord.xy * 2 - 1;
				float kaleido_length = length(uv);
				float kaleido_atan = atan2(uv.x,uv.y) + _Rotate;
				_Amount += 0.00001;
				float kaleido_pi = 3.14159265358979 * 2 / _Amount;
				float kaleido_mask = floor((kaleido_atan / kaleido_pi)) * kaleido_pi;
				kaleido_mask = abs(kaleido_atan - kaleido_mask - kaleido_pi * 0.5);

				float2 kaleido_uv = float2(cos(kaleido_mask),sin(kaleido_mask)) * kaleido_length * 0.1;
				float m_time = _Time.y * _TimeScale + _Offset_X;
				float m_time_cos = cos(m_time);
				float m_time_sin = sin(m_time);
				uv.x = kaleido_uv.x * m_time_cos - kaleido_uv.y * m_time_sin - _TimeScale * m_time_sin - _Offset_Y;
				uv.y = kaleido_uv.x * m_time_sin + kaleido_uv.y * m_time_cos + _TimeScale * m_time_cos + _Offset_Y;
				uv *= _Scale;
			
				// 贴图采样
				color *= tex2D(_MainTex, uv);

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

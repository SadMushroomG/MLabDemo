// https://lilithgames.feishu.cn/wiki/wikcnAolyQezE3TIKNijUKdbmiY
// ver 2.0 通用大版本迭代
//Author: 邹沐阳
//Date:2022.03.08
//作用于UI界面旗帜摆动的定制化shader

Shader "UEP/Interface/FlagSwing"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}

		_SqueezeValue("_SqueezeValue", Range(-50 , 50)) = 0
		_RotateDegrees("_RotateDegrees(旋转角度)",  Range(-30 , 30)) = 0
		_WaveSpeed("_WaveSpeed", Range(-1 , 1)) = 0
		_WaveIntensity("_WaveIntensity", Range(-2.5, 2.5)) = 1
		_WindPara("_WindPara", Range(-1.5, 1.5)) = 1

		_WaveNum("_WaveNum", Int) = 12
		_SpecularMulti("_SpecularMulti", Float) = 1
		_ShadowMulti("_ShadowMulti", Float) = 1

		[HideInInspector]_StencilComp("Stencil Comparison", Float) = 8
		[HideInInspector]_Stencil("Stencil ID", Float) = 0
		[HideInInspector]_StencilOp("Stencil Operation", Float) = 0
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

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest[unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			Name "effect_cis_flag_swing"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile_local _ UNITY_UI_CLIP_RECT

			struct appdata_t
			{
				fixed4 vertex   : POSITION;
				fixed2 texcoord : TEXCOORD0;
				fixed4 color    : COLOR;
			};

			struct v2f
			{
				fixed4 vertex   : SV_POSITION;
				fixed2 texcoord  : TEXCOORD0;
				fixed4 color    : COLOR;
				fixed4 worldPosition : TEXCOORD1;
			};

			sampler2D _MainTex;
			fixed4 _ClipRect;
			//CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				fixed _SqueezeValue;
				fixed _RotateDegrees;
				fixed _WaveSpeed;
				fixed _WaveIntensity;
				fixed _WindPara;
				fixed _SpecularMulti;
				fixed _ShadowMulti;

				int _WaveNum;
			//CBUFFER_END

			v2f vert(appdata_t v)
			{
				v2f OUT;
				OUT.worldPosition = v.vertex;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);
				OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				OUT.color = v.color;
				return OUT;
			}

			// 旋转
			fixed2 Unity_Rotate_Degrees_fixed(fixed2 UV, fixed2 Center, fixed Rotation)
			{
				Rotation = Rotation * (3.1415926f/180.0f);
				UV -= Center;
				fixed s = sin(Rotation);
				fixed c = cos(Rotation);
				fixed2x2 rMatrix = fixed2x2(c, -s, s, c);
				rMatrix *= 0.5;
				rMatrix += 0.5;
				rMatrix = rMatrix * 2 - 1;
				UV.xy = mul(UV.xy, rMatrix);
				UV += Center;
				return UV;
			}
				
			float random (float n) {
				return frac(sin(n)*1000000.);
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				#ifdef UNITY_UI_CLIP_RECT
					fixed alpha_clip = UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
					if(alpha_clip < 0.001)
					{
						return 0;
					}
				#endif

				fixed2 squeezeUV = IN.texcoord;
				//方便动效K帧，乘0.01
				squeezeUV.x += pow((1 - squeezeUV.y), 3) * _SqueezeValue * 0.01;
					
				fixed2 rotateUV = Unity_Rotate_Degrees_fixed(IN.texcoord, fixed2(0.5, 1), _RotateDegrees);
					
				fixed dis = distance(IN.texcoord, fixed2(0.5, 1));
				rotateUV = lerp(IN.texcoord, rotateUV, dis);
				fixed2 uv = lerp(squeezeUV, rotateUV, 0.5);

				fixed2 noiseUV = lerp(uv, rotateUV, _WindPara);
				float noise = (0.5 * sin((noiseUV.x + _Time.y * _WaveSpeed) * 3.1415926f * _WaveNum) + 1) * _WaveIntensity;

				//noise *= pow((1-uv.y), 3);

				uv += lerp(fixed2(0, 0) , noise * fixed2(-0.02, 0), pow((1-uv.y), 3));
					
				half4 color = tex2D(_MainTex, uv) * IN.color;

				fixed specular = pow(noise*color.a * pow((1-uv.y), 2), 1) * 0.8;
				color.rgb = lerp(color.rgb, color.rgb * _SpecularMulti, specular);
				fixed shadow = pow((1-noise)*color.a * pow((1-uv.y), 2), 2);
				color.rgb = lerp(color.rgb, color.rgb * _ShadowMulti, shadow);

				return color;
				//return fixed4(noise, noise, noise, 1);
			}
		ENDCG
		}
	}
	CustomEditor "ShaderHelpUniversal"
}

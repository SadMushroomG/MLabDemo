
Shader "UEP/Interface/PlayerHead"
{
	Properties
	{
		[Header(Main)][Space(5)]
		[PerRendererData]_MainTex ("_MainTex", 2D) = "white" {}
		_MainColor ("_MainColor", Color) = (1,1,1,1)

		[Header(Bg)][Space(5)]
		_BgTex ("_BgTex", 2D) = "white" {}
		_BgColor ("_BgColor", Color) = (1,1,1,1)

		[Header(Setting)][Space(5)]
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("_ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("_ZTest(深度检测)", int) = 8
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("_Cull(剔除)", int) = 2
		
		[Header(Clip)][Space(5)]
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

		[Header(Stencil)][Space(5)]
		_Stencil ("_Stencil", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("_StencilComp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("_StencilOp", Float) = 0
        
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

		Cull [_Cull]
		ZWrite [_ZWrite]
		ZTest [_ZTest]
		Blend [_SrcBlend] [_DstBlend]

		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp]
		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile __ UNITY_UI_ALPHACLIP

			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float4 texcoord  : TEXCOORD0;
			};
			
			
			sampler2D _MainTex,_BgTex;
			float4 _MainTex_ST,_BgTex_ST;
			fixed4 _MainColor,_BgColor;
			float _AlphaSplitEnabled,_AlphaClipThreshold;


			v2f vert(appdata_t IN)
			{
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);

				OUT.texcoord.xy = TRANSFORM_TEX(IN.texcoord,_MainTex);
				OUT.texcoord.zw = TRANSFORM_TEX(IN.texcoord,_BgTex);

				OUT.color = IN.color;

				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}


			fixed4 frag(v2f IN) : SV_Target
			{
				half4 c = IN.color;
				half4 main_tex  = tex2D (_MainTex, IN.texcoord.xy) * _MainColor;
				half4 bg_tex = tex2D(_BgTex,  IN.texcoord.zw) * _BgColor;
				c.rgb *= lerp(bg_tex.rgb,main_tex.rgb,main_tex.a);
				c.a *= bg_tex.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ShaderEditorUniversal"
}
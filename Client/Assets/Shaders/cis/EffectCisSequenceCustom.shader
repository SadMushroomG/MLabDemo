// https://lilithgames.feishu.cn/wiki/UCdvwleYpimMITkhllDcexFvnIh
// Ver 1.0 传入数组控制每一帧的播放时长
Shader "UEP/Interface/Sequence_custom"
{
	Properties
	{
		[PerRendererData] _MainTex("_MainTex(主贴图)", 2D) = "white" {}
		_HorAmount("_HorAmount(序列图横向数量,一行几个)", int) = 3
		[Toggle(UEP_VARIANT_1)]_Frame9or16("_Frame9or16(16帧请开启该参数)", int) = 0
		_TotalDuration("_TotalDuration(该参数由外部传入请勿填写)", float) = 0.1   //序列帧总播放时长

		[Header(Setting)]
		[Space]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("_SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("_DstBlend", int) = 10
		[Toggle]_ZWrite("_ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("_ZTest(深度检测)", int) = 8
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("_Cull(剔除)", int) = 2
		[Header(Clip)]
		[Space]
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", int) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001
		[Header(Stencil)]
		[Space]
		_Stencil("Stencil ID", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Comparison", int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("Stencil Operation", int) = 0
		[HideInInspector]_StencilWriteMask("Stencil Write Mask", int) = 255
		[HideInInspector]_StencilReadMask("Stencil Read Mask", int) = 255

		//[HideInInspector]_GammaRadio("Gamma Radio", Float) = 1
	}
	SubShader
	{
		Tags 
		{ 
			"RenderType"="Transparent"
			"Queue"="Transparent"
			"IgnoreProjector"="True"
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

		Blend[_SrcBlend][_DstBlend]
		Cull[_Cull]
		ZTest[_ZTest]
		ZWrite[_ZWrite]

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			//#pragma enable_d3d11_debug_symbols
			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			#pragma shader_feature_local __ UEP_VARIANT_1 //开启后是16帧

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 vertexColor : COLOR;

			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 vertexColor : COLOR;
				float4 param : TEXCOORD0;		//xy:uv zw:worldPosition
				float2 rectmask : TEXCOORD1;
			};

			sampler2D _MainTex;
			fixed4 _ClipRect;
			float _HorAmount,_TotalDuration;
			fixed _AlphaClipThreshold;

			#ifdef UEP_VARIANT_1
				float _FrameDurations[16];
			#else
				float _FrameDurations[9];
			#endif


			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vertexColor = v.vertexColor;
				o.param.xy = v.uv;
				 
				// 获取当前时间
				float currentTime = fmod(_Time.y, _TotalDuration);
				// 计算当前是哪一帧
				int currentFrame = 0;
				float accumulatedTime = 0.0;

				#ifdef UEP_VARIANT_1
					for (int frame = 0; frame < 16; ++frame) 
					{
						accumulatedTime += _FrameDurations[frame];

						if (currentTime <= accumulatedTime) {
							currentFrame = frame;
							break;
						}
					}
					#else
					for (int frame = 0; frame < 9; ++frame) 
					{
						accumulatedTime += _FrameDurations[frame];

						if (currentTime <= accumulatedTime) {
							currentFrame = frame;
							break;
						}
					}
				#endif

				o.param.z = currentFrame;
				o.rectmask = v.vertex.xy;

				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = 1;

				#ifdef UNITY_UI_CLIP_RECT
					col.a *= UnityGet2DClipping(i.rectmask.xy, _ClipRect);
					if(col.a < 0.001)
					{
						return 0;
					}
				#endif



				// 计算当前帧的行列位置
				int column = i.param.z % _HorAmount;
				int row = i.param.z / _HorAmount;

				// 计算UV坐标 
				float2 spriteSize = float2(1.0 / _HorAmount, 1.0 / _HorAmount);
				float2 spritePosition = float2(column * spriteSize.x, 1.0 - (row + 1) * spriteSize.y);

				float2 frameUV = i.param.xy * spriteSize + spritePosition;

				col = tex2D(_MainTex, frameUV);

				#ifdef UNITY_UI_ALPHACLIP
					clip(col.a - _AlphaClipThreshold);
				#endif

				return col;
			}
			ENDCG
		}
	}
	CustomEditor "ShaderEditorUniversal"
}

// 头像合并Blit
Shader "UEP/Interface/ChatHeadBlit"
{
	Properties
	{
		[PerRendererData] _MainTex("_MainTex(主贴图)", 2D) = "white" {}
		_Color("Color",color) = (0.5,1,0,1)

		_ProfileTex1("_ProfileTex1(图1)",2D) = "white"{}
		_ProfileTex2("_ProfileTex2(图2)",2D) = "white"{}
		_ProfileTex3("_ProfileTex3(图3)",2D) = "white"{}
		_ProfileTex4("_ProfileTex4(图4)",2D) = "white"{}

		[Header(PictureOne)][Space(5)]
		_ImageUV_1("_ImageUV_1(1张图时UV参数)",vector) = (1,1,0,0)

		[Header(PictureTwo)][Space(5)]
		_Rotate_2("_Rotate_2(2张图时旋转值(要大于0))",range(0,1)) = 0
		_ImageUV_2_1("_ImageUV_2_1(2张图时图1UV参数)",vector) = (1,1,0,0)
		_ImageUV_2_2("_ImageUV_2_2(2张图时图2UV参数)",vector) = (1,1,0,0)

		[Header(PictureThree)][Space(5)]
		_Rotate("_Rotate(3张图时旋转值(要大于0))",range(0,2)) = 0
		_ImageUV_3_1("_ImageUV_3_1(3张图时图1的UV参数)",vector) = (1,1,0,0)
		_ImageUV_3_2("_ImageUV_3_2(3张图时图2的UV参数)",vector) = (1,1,0,0)
		_ImageUV_3_3("_ImageUV_3_3(3张图时图3的UV参数)",vector) = (1,1,0,0)

		[Header(PictureFour)][Space(5)]
		_ImageUV_4("_ImageUV_4(4张图时UV参数)",vector) = (1,1,0,0)

		[Header(ImageUVControl)][Space(5)]
		//_HeroRatio_1_X("_HeroRatio_1_X(旧版本代码图1的UV比例调整)",float) = 1.378
		_HeroRatio_1("_HeroRatio_1(图1的UV比例)",float) = 1
		_HeroRatio_2("_HeroRatio_2(图2的UV比例)",float) = 1
		_HeroRatio_3("_HeroRatio_3(图3的UV比例)",float) = 1
		_HeroRatio_4("_HeroRatio_4(图4的UV比例)",float) = 1
		_HeroOffset_1("_HeroOffset_1(图1的UV偏移)",float) = 0
		_HeroOffset_2("_HeroOffset_2(图2的UV偏移)",float) = 0
		_HeroOffset_3("_HeroOffset_3(图3的UV偏移)",float) = 0
		_HeroOffset_4("_HeroOffset_4(图4的UV偏移)",float) = 0
		_Test1("_Test1(图4的UV偏移)",float) = 0
		_Test2("_Test2(图4的UV偏移)",float) = 0

		[Header(ImageIsFlip)][Space(5)]
		_UVFlip_1("_UVFlip_1(图1是否翻转)",float) = 0
		_UVFlip_2("_UVFlip_2(图2是否翻转)",float) = 0
		_UVFlip_3("_UVFlip_3(图3是否翻转)",float) = 0
		_UVFlip_4("_UVFlip_4(图4是否翻转)",float) = 0

		[Header(Setting)][Space(5)]
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

		[Header(Clip)][Space(5)]
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

		[HideInInspector]_ColorMask("Color Mask", Float) = 15
			//[HideInInspector]_GammaRadio("Gamma Radio", Float) = 1

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
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"
			#pragma shader_feature_local __ UEP_VARIANT_1					// 1个
			#pragma shader_feature_local __ UEP_VARIANT_2					// 2个
			#pragma shader_feature_local __ UEP_VARIANT_3					// 3个
			#pragma shader_feature_local __ UEP_VARIANT_4					// 4个


			struct appdata_t
			{
				float4 vertex   : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			}; 

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color : COLOR;
				float4 texcoord  : TEXCOORD0;
			};

			sampler2D _MainTex;
			half4 _ImageUV_1, _ImageUV_2_1, _ImageUV_2_2, _ImageUV_3_1, _ImageUV_3_2, _ImageUV_3_3, _ImageUV_4;
			float4 _Image_1_UV,_Image_2_UV,_Image_3_UV,_Image_4_UV;
			float _HeroRatio_1 , _HeroRatio_2 , _HeroRatio_3 , _HeroRatio_4;
			//float _HeroRatio_1_X;
			half _UVFlip_1,_UVFlip_2,_UVFlip_3,_UVFlip_4,_Test2,_Test1;
			float _HeroOffset_1,_HeroOffset_2,_HeroOffset_3,_HeroOffset_4;

			#ifdef UEP_VARIANT_1
				sampler2D _ProfileTex1;
			#endif


			#ifdef UEP_VARIANT_2
				sampler2D _ProfileTex1, _ProfileTex2;
				half _Rotate_2;
			#endif

			#ifdef UEP_VARIANT_3
				sampler2D _ProfileTex1, _ProfileTex2, _ProfileTex3;
				half _Rotate;
			#endif

			#ifdef UEP_VARIANT_4
				sampler2D _ProfileTex1, _ProfileTex2, _ProfileTex3, _ProfileTex4;
			#endif

			half4 _Color;

			v2f vert(appdata_t v)
			{
				v2f OUT;
				OUT.texcoord.zw = v.vertex.xy;
				OUT.vertex = UnityObjectToClipPos(v.vertex);
				OUT.texcoord.xy = v.texcoord;
				OUT.color = v.color;

				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				// 贴图采样
				half4 color = _Color;
				half mask = 0;
				half2 uv = IN.texcoord.xy;
				half uv_y_flip = 1 - uv.y;
				
				#ifdef UEP_VARIANT_1
				//1张图
					half2 uv_1 = half2(uv.x,lerp( uv.y , (1 - uv.y) , _UVFlip_1));
					half2 profile_uv_1 = half2(uv_1.x, uv_1.y * _HeroRatio_1 + _HeroOffset_1) * _ImageUV_1.x + _ImageUV_1.zw;
					half4 profile_tex_1 = tex2D(_ProfileTex1, profile_uv_1);

					color *= profile_tex_1;
				#endif


				#ifdef UEP_VARIANT_2
				//2张图
					half2 uv_1 = half2(uv.x,lerp( uv.y , (1 - uv.y) + _Test1 , _UVFlip_1));
					half2 uv_2 = half2(uv.x,lerp( uv.y , (1 - uv.y) + _Test2 , _UVFlip_2));

					half2 profile_uv_1 = half2(uv_1.x , uv_1.y * _HeroRatio_1 + _HeroOffset_1) * _ImageUV_2_1.x + _ImageUV_2_1.zw;
					half2 profile_uv_2 = half2((uv_2.x - 0.5) , uv_2.y * _HeroRatio_2 + _HeroOffset_2) * _ImageUV_2_2.x + _ImageUV_2_2.zw;
					half4 profile_tex_1 = tex2D(_ProfileTex1, profile_uv_1);
					half4 profile_tex_2 = tex2D(_ProfileTex2, profile_uv_2);
					half2 mask1 = uv - 0.5;
					mask = fmod(atan2(mask1.x, mask1.y) / 6.28319 + 0.5 + _Rotate_2,1);
					mask = step(0.5, mask);
					color *= lerp(profile_tex_1, profile_tex_2, mask);
				#endif

				#ifdef UEP_VARIANT_3
				//3张图
					half2 uv_1 = half2(uv.x,lerp( uv.y , (1 - uv.y) - _ImageUV_3_1.w , _UVFlip_1)); 
					half2 uv_2 = half2(uv.x,lerp( uv.y , (1 - uv.y) - _ImageUV_3_2.w , _UVFlip_2));
					half2 uv_3 = half2(uv.x,lerp( uv.y , (1 - uv.y) -0.5 , _UVFlip_3));

					half2 profile_uv_1 = half2(uv_1.x, uv_1.y * _HeroRatio_1 + _HeroOffset_1) * _ImageUV_3_1.x + _ImageUV_3_1.zw;
					half2 profile_uv_2 = half2(uv_2.x, uv_2.y * _HeroRatio_2 + _HeroOffset_2) * _ImageUV_3_2.x + _ImageUV_3_2.zw;
					half2 profile_uv_3 = half2(uv_3.x, uv_3.y * _HeroRatio_3 + _HeroOffset_3) * _ImageUV_3_3.x + _ImageUV_3_3.zw;

					half4 profile_tex_1 = tex2D(_ProfileTex1, profile_uv_1);
					half4 profile_tex_2 = tex2D(_ProfileTex2, profile_uv_2);
					half4 profile_tex_3 = tex2D(_ProfileTex3, profile_uv_3);
					half2 mask1 = uv - 0.5;
					mask = fmod(atan2(mask1.x, mask1.y) / 6.28319 + 0.5 + _Rotate,1);
					if (mask > 0.667)
					{
						color *= profile_tex_3;
					}
					else if (mask < 0.334)
					{
						color *= profile_tex_1;
					}
					else
					{
						color *= profile_tex_2;
					}
				#endif

				#ifdef UEP_VARIANT_4
				//4张图
					half2 uv_1 = half2(uv.x,lerp( uv.y , (1 - uv.y) + 0.5, _UVFlip_1));
					half2 uv_2 = half2(uv.x,lerp( uv.y , (1 - uv.y) + 0.5, _UVFlip_2));
					half2 uv_3 = half2(uv.x,lerp( uv.y , (1 - uv.y) - 0.5, _UVFlip_3));
					half2 uv_4 = half2(uv.x,lerp( uv.y , (1 - uv.y) - 0.5, _UVFlip_4)); 

					half2 profile_uv_1 = half2(uv_1.x ,(uv_1.y - 0.5)* _HeroRatio_1 + _HeroOffset_1) * _ImageUV_4.x + _ImageUV_4.zw;
					half2 profile_uv_2 = half2((uv_2.x - 0.5) ,(uv_2.y - 0.5)* _HeroRatio_2 + _HeroOffset_2) * _ImageUV_4.x + _ImageUV_4.zw;
					half2 profile_uv_3 = half2(uv_3.x , uv_3.y * _HeroRatio_3 + _HeroOffset_3) * _ImageUV_4.x + _ImageUV_4.zw;
					half2 profile_uv_4 = half2((uv_4.x - 0.5) , uv_4.y * _HeroRatio_4 + _HeroOffset_4) * _ImageUV_4.x + _ImageUV_4.zw;

					half4 profile_tex_1 = tex2D(_ProfileTex1, fmod(profile_uv_1,1));
					half4 profile_tex_2 = tex2D(_ProfileTex2, fmod(profile_uv_2, 1));
					half4 profile_tex_3 = tex2D(_ProfileTex3, fmod(profile_uv_3, 1));
					half4 profile_tex_4 = tex2D(_ProfileTex4, fmod(profile_uv_4, 1));
					half mask_1 = step(0.5, uv.x);
					half mask_2 = step(0.5, uv.y);
					half4 color_1 = lerp(profile_tex_1, profile_tex_2, mask_1);
					half4 color_2 = lerp(profile_tex_3, profile_tex_4, mask_1);
					color *= lerp(color_2, color_1, mask_2);
				#endif


				return color * color.a;
			}
			ENDCG
		}
	}
	//CustomEditor "ShaderEditorUniversal"
}

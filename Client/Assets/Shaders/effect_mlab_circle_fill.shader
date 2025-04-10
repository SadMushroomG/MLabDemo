Shader "MLab/Common/CircleFill"  
{  
	Properties  
	{  
		[PerRendererData] _MainTex("_MainTex", 2D) = "white" {}  
		_IconTex("_IconTex",2D) = "white"{}
		
		_Progress("_Progress(圆环填充百分比)", Range(0, 1)) = 0  
		_StartAngle("_StartAngle(起始角度)", Range(0, 1)) = 0  

		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Comparison", Float) = 8  
		_Stencil("Stencil ID", Float) = 0  
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("Stencil Operation", Float) = 0  
		[HideInInspector]_StencilWriteMask("Stencil Write Mask", Float) = 255  
		[HideInInspector]_StencilReadMask("Stencil Read Mask", Float) = 255  
		[HideInInspector]_ColorMask("Color Mask", Float) = 15  

		[HideInInspector][Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0  
	}  

	SubShader  
	{  
		Tags   
		{   
			"RenderType" = "Transparent"  
			"Queue" = "Transparent"  
			"CanUseSpriteAtlas" = "True"  
			"PreviewType"="Plane"  
			"CanUseSpriteAtlas"="True"  
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
		ZTest Always  
		Blend SrcAlpha OneMinusSrcAlpha  
		ColorMask [_ColorMask]  

		Pass  
		{  
			Name "Default"  

			CGPROGRAM  
			#pragma vertex vert  
			#pragma fragment frag  
			//#pragma target 2.0  

			#include "UnityCG.cginc"  
			#include "UnityUI.cginc"  
			//#include "Common/ColorCommon.cginc"  

			#pragma multi_compile __ UNITY_UI_CLIP_RECT  
			#pragma multi_compile __ UNITY_UI_ALPHACLIP  
            #pragma shader_feature_local __ UEP_VARIANT_1					// _DissolveMask 溶解Mask  

			//#pragma shader_feature _Mask  

			struct appdata_t  
			{  
				half4 vertex   : POSITION;  
				float2 texcoord : TEXCOORD0;  
                fixed4 vertexColor : COLOR;  
			};  

			struct v2f  
			{  
				half4 vertex   : SV_POSITION;  
				float4 texcoord  : TEXCOORD0;  
				float2 worldPosition : TEXCOORD1;  
                fixed4 vertexColor : COLOR;  
				//UNITY_VERTEX_OUTPUT_STEREO  
			};  

			sampler2D _MainTex;  
			sampler2D _IconTex;
			half4 _ClipRect;  
			CBUFFER_START(UnityPerMaterial)  
				half4 _MainTex_ST;  
				float4 _IconTex_ST;
				half4 _Color;  
				fixed _Progress;  
				fixed _StartAngle;  
			CBUFFER_END  

			v2f vert(appdata_t v)  
			{  
				v2f OUT;  
				OUT.worldPosition = v.vertex.xy;  
				OUT.vertex = UnityObjectToClipPos(v.vertex);  

				OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);  
				OUT.texcoord.zw = TRANSFORM_TEX(v.texcoord, _IconTex);  
				OUT.vertexColor = v.vertexColor;  
				return OUT;  
			}  

			float4 frag(v2f IN) : SV_Target  
			{  
				#ifdef UNITY_UI_CLIP_RECT  
					half _clip = UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);  
					if (_clip < 0.001)  
					{  
						return 0;  
					}  
				#endif  

				float2 center = float2(0.5, 0.5);  
				float2 uv = IN.texcoord - center;  
				float angle = atan2(uv.y, uv.x) / (2 * 3.14159265359) + 0.5;  
				angle = frac(angle - _StartAngle);  
				if (angle > _Progress)  
				{  
					return 0;  
				}  

				float4 icon_color = tex2D(_IconTex,IN.texcoord.zw);
				float icon_gray = 0.299 * icon_color.r + 0.587 * icon_color.g + 0.114 * icon_color.b;
				float4 color = lerp(IN.vertexColor,float4(icon_gray,icon_gray,icon_gray,icon_gray),icon_color.a);

				color.a = tex2D(_MainTex, IN.texcoord.xy).a;  

				#ifdef UNITY_UI_ALPHACLIP  
					if(color.a < 0.001)  
					{  
						return 0;  
					}  
				#endif  

				return color;  
			}  
		ENDCG  
		}  
	}  
}

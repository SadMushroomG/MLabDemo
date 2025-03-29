// https://lilithgames.feishu.cn/wiki/wikcn3w7tKrvC5eOODNa7hqOCmh
// ver 2.0 通用大版本迭代
//written by YuXiang
//2022.04.26
//Simple Radial Bur

Shader "UEP/Interface/SimpleRadialBlur"
{
	Properties
	{
		[PerRendererData]_MainTex ("Texture", 2D) = "white" {}
		_BlurLevel("_BlurLevel",Range(1,20))=10
		_CenterX("_CenterX",Range(0,1))=0.5
		_CenterY("_CenterY",Range(0,1))=0.5
		_RadiusPower("_RadiusPower",Range(0,1))=0.02
		_RadiusCenterRange("_RadiusCenterRange",Range(0,1))=0

		[Header(Setting)]
		[Space]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("Blend mode", int) = 0
        [HideInInSpector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [HideInInspector][Enum(UnityEngine.Rendering.BlendOp)] _BlendOp("BlendOp", int) = 0
        [Toggle]_ZWrite("ZWrite", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", int) = 0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull", int) = 2
	}
	SubShader
	{
		Tags 
		{ 
			"Queue" = "Transparent" 
            "RenderType"="Transparent" 
            "CanUseSpriteAltas" = "True"
			"PreviewType"="Plane"
			"IgnoreProjector"="true"
		}

		Pass
		{
			Blend[_SrcBlend][_DstBlend]
            BlendOp[_BlendOp]
            Cull[_Cull]
            ZTest[_ZTest]
            ZWrite[_ZWrite]

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 vertexColor : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				fixed4 vertexColor : COLOR;
			};

			sampler2D _MainTex;
			//CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				int _BlurLevel;
				fixed _CenterX;
				fixed _CenterY;
				fixed _RadiusCenterRange;
				fixed _RadiusPower;
			//CBUFFER_END

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.vertexColor = v.vertexColor;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//设置径向模糊的中心位置
				//fixed2 center = fixed2(_CenterX - i.uv.x,_CenterY - i.uv.y)*_RadiusPower;
				fixed2 center = fixed2(_CenterX - i.uv.x,_CenterY - i.uv.y);
				fixed range_amount = 1;
				if(_RadiusCenterRange > 0)
				{
					half square_dis = dot(center,center);
					half square_range = _RadiusCenterRange * _RadiusCenterRange;
					//range_amount = square_dis >= square_range ? 1: 0;
					range_amount = saturate((square_dis - square_range)/square_range);

				}

				//计算像素与中心点的距离，距离越远偏移越大
				//fixed2 uv = i.uv - center;
				fixed4 col1 = fixed4(0,0,0,0);
				for (fixed j = 0; j < _BlurLevel; j++)
				{
					//根据设置的level对像素进行叠加，然后求平均值
					//col1 += tex2D(_MainTex, uv*(1 - 0.01*j) + center).rgb;
					col1 += tex2D(_MainTex,i.uv);
					i.uv += center * _RadiusPower * range_amount;
				}

				fixed4 col =fixed4(col1.rgb,col1.a)/_BlurLevel;
				
				return col*i.vertexColor;
			}
			ENDCG
		}
	}
	CustomEditor "ShaderEditorUniversal"
}

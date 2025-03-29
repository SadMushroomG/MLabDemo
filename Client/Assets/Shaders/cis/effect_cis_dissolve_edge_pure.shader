// https://lilithgames.feishu.cn/wiki/wikcnQpvsWhUSbdPUDscoOV3dsg
// ver 2.0 通用大版本迭代
//written by YuXiang
//2022.04.13
//Pure Dissolve Edge

Shader "UEP/Interface/DissolveEdgePure"
{
	Properties
	{

	   [PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		[HDR]_MainColor("_MainColor(主图颜色)" , COLOR) = (1,1,1,1)
		_EdgeTex("_EdgeTex(边线贴图)" , 2D) = "white" {}
		_DissolveTex("_DissolveTex(溶解贴图)" , 2D) = "white" {}
		[HDR]_EdgeColor("_EdgeColor(边线颜色)" , COLOR) = (1,1,1,1)
		_MainTexParam("_MainTexParam(x:主帖图溶解进度 y:主帖图溶解软边)",Vector) = (0.5,0.1, 0, 0)
		_EdgeParam("_EdgeParam(x:边线溶解进度 y:边线溶解宽度 z:边线溶解软边)",Vector) = (0.5,0.15,0.15,0)

	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
		}

		ZTest Always
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed4 vertexColor : COLOR;
				fixed2 uv : TEXCOORD0;
			};

			struct v2f
			{
				fixed4 vertex : SV_POSITION;
				fixed4 vertexColor : COLOR;
				fixed2 uv : TEXCOORD0;
				fixed2 uvdissolve : TEXCOORD1;
			};

			sampler2D _MainTex,_EdgeTex,_DissolveTex;
			//CBUFFER_START(UnityPerMaterial)
				fixed4 _MainTex_ST,_EdgeTex_ST,_DissolveTex_ST,_EdgeColor,_MainColor,_MainTexParam,_EdgeParam;
			//CBUFFER_END

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vertexColor = v.vertexColor;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvdissolve = TRANSFORM_TEX(v.uv, _DissolveTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 maintex = tex2D(_MainTex, i.uv);
				fixed edgetex = tex2D(_EdgeTex, i.uv).r;
				fixed dissolvetex = tex2D(_DissolveTex, i.uvdissolve);

				//反转一下溶解值
				_MainTexParam.x *= -1;
				//主图溶解
				fixed dis_main = smoothstep(_MainTexParam.x , _MainTexParam.x + _MainTexParam.y , dissolvetex);

				//边缘线溶解
				fixed dis_edge_big = smoothstep(_EdgeParam.x - _EdgeParam.y  , _EdgeParam.x + _EdgeParam.z , dissolvetex);
				fixed dis_edge_small = smoothstep(_EdgeParam.x, _EdgeParam.x + _EdgeParam.z , dissolvetex);
				fixed dis_edge = saturate(dis_edge_big - dis_edge_small) * edgetex;

				//最终溶解
				fixed dis_final = saturate(dis_edge + dis_main);

				fixed4 col = maintex * _MainColor + dis_edge * _EdgeColor;
				col.a = dis_final;
				col *= i.vertexColor;

				return col;
			}
			ENDCG
		}
	}
	CustomEditor "ShaderHelpUniversal"
}

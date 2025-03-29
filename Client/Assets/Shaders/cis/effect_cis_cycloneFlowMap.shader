Shader "UEP/Interface/CycloneFlowMap"
{
	Properties
	{
		_MainTex("Sprite Texture", 2D) = "white" {}
		
		_Color("Tint", Color) = (0,0,0,0)

		_Mask("_Mask", 2D) = "white" {}

		_FlowStrength("Flow Strenth", float) = 0.05
		_FlowSpeed("Flow Speed", float) = 0.05
		_CycleRadius("Cycle Flow Radius", float) = 0.6

		_RotateCenter("Rotate Center", Vector) = (0.5,0.5,0.0,0.0)

		[Enum(One,1,SrcAlpha,5)] _SrcBlend("_SrcBlend(混合模式SrcBlend)", Float) = 5
		[Enum(One,1,OneMinusSrcAlpha,10)] _DstBlend("_DstBlend(混合模式DstBlend)", Float) = 10

		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", int) = 0
		[Toggle]_ZWrite("ZWrite", Int) = 0

		[MaterialToggle] PixelSnap("Pixel snap", Float) = 0

		[IntRange] _StencilID("Stencil ID", Range(0, 255)) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _CompareFunction("CompareFunction", int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp("Stencil Op", int) = 0
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

				Cull Off
				Lighting Off

				ZTest[_ZTest]
				ZWrite[_ZWrite]

				Blend[_SrcBlend][_DstBlend]
				

				Pass
				{
					Stencil
					{
						Ref[_StencilID]
						Comp[_CompareFunction]
						Pass [_StencilOp]
						Fail Keep
					}

					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					#pragma multi_compile _ PIXELSNAP_ON
					#pragma multi_compile  _ LD_LOD300 
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
						fixed4 color : COLOR;
						half2 texcoord  : TEXCOORD0;
					};

					// makes a simple flowmap of a cyclone
					float2 cycloneFlow(float2 pt, float radius, float time) {
						float size = 2. / (1.4 * sqrt(radius)); // of the entire cyclone
						float curl = 2.5; // kind of arbitrary but between 1-3.5 looks good
						float hole = 1. / (4.*size); // also kind of arbitrary

						float angle = atan2(pt.y, pt.x); //angle around center
						float dist = length(pt); // distance to point
						float spiral = frac(dist / radius + (angle * 0 - time) / 6.2831853072);

						//right slanted donut https://www.desmos.com/calculator/ocm71awnym
						spiral -= 1.212; //
						spiral = 1. + (pow(1.57*(spiral)+0.8, 2.) / spiral);

						float flowAngle = 3.1415926536 + angle - (dist*curl) - (spiral*0.8);

						flowAngle = 3.1415926536 / 2 + angle;

						// left slanted donut https://www.desmos.com/calculator/uxyefly7fi
						float spiralStrength = 0.05; // makes sure mask is 0-1 range
						float mask = (1. - spiralStrength) - (pow(dist*size - hole, 2.0) / dist);
						mask += spiral * spiralStrength;
						mask = clamp(mask, 0.0, 1.0);  // saturate

						float2 flow = normalize(float2(cos(flowAngle), sin(flowAngle)));
						flow *= mask; // apply strength mask

						return flow;
					}

					// makes a simple flowmap of a cyclone
					float2 cycleFlow(float2 pt, float radius, float time) {
						float size = 2. / (1.4 * sqrt(radius)); // of the entire cyclone
						float hole = 1. / (4.*size); // also kind of arbitrary

						float angle = atan2(pt.y, pt.x); //angle around center
						float dist = length(pt); // distance to point

						float flowAngle = 3.1415926536 / 2 + angle;

						float mask = 1 - (pow(dist*size - hole, 2.0) / dist);
						mask = saturate(mask);  // saturate

						float2 flow = normalize(float2(cos(flowAngle), sin(flowAngle)));
						flow *= mask; // apply strength mask

						return flow;
					}

					//shifts value range from -1-1 to 0-1
					float2 make0to1(float2 x) {
						return (1.0 + x) / 2.0;
					}

					v2f vert(appdata_t IN)
					{
						v2f OUT;

						OUT.vertex = UnityObjectToClipPos(IN.vertex);
						OUT.texcoord = IN.texcoord;
						OUT.color = IN.color;
						#ifdef PIXELSNAP_ON
						OUT.vertex = UnityPixelSnap(OUT.vertex);
						#endif

						return OUT;
					}

					sampler2D _MainTex;
					sampler2D _Mask;

					float _FlowSpeed;
					float _FlowStrength;
					float _CycleRadius;
					float4 _RotateCenter;

					fixed4 _Color;

					fixed4 frag(v2f IN) : SV_Target
					{
#ifndef LD_LOD300
						float2 flowMap = cycleFlow(IN.texcoord - _RotateCenter.xy, _CycleRadius, _Time.y);
#else
						float2 flowMap = 0;
#endif
						//flowMap = make0to1(flowMap);


						flowMap *= _FlowStrength;


						float phase0 = frac(_Time.y * _FlowSpeed + 0.5f);
						float phase1 = frac(_Time.y * _FlowSpeed + 1.0f);

						float mask = tex2D(_Mask, IN.texcoord).r;

						half4 tex0 = tex2D(_MainTex, IN.texcoord - flowMap.xy * mask * phase0);
						half4 tex1 = tex2D(_MainTex, IN.texcoord - flowMap.xy * mask * phase1);

						float flowLerp = abs((0.5f - phase0) / 0.5f);
						half4 finalColor = lerp(tex0, tex1, flowLerp);

						finalColor *= _Color * IN.color;
						
						return finalColor;
					}
					ENDCG
				}
			}
			CustomEditor "ShaderHelpUniversal"
}
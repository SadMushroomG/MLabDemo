// https://lilithgames.feishu.cn/wiki/wikcnl13RJZ82HqJuM6fh9FFRbb
// ver 2.0 通用大版本迭代
//written by YiRu
//2022.3.4
//UI FlowMap Shader

Shader "UEP/Interface/FlowMap"
{
    Properties
    {
        [NonModifiableTextureData]_MainTex ("_MainTex(主贴图) _MainTex_ST(TillingAndOffset)", 2D) = "white" {}
        [NoScaleOffset]_Flowmap ("_Flowmap(Flowmap贴图，要去掉SRGB)", 2D) = "grey" {}
        [NoScaleOffset]_MaskTex ("_MaskTex(mask贴图)", 2D) = "white" {}
		_Color("Tint Color", Color) = (1,1,1,1)
        _MaskSmoothstepMin("_MaskSmoothstepMin(遮罩调整)",Float)=0 
        _MaskSmoothstepMax("_MaskSmoothstepMax(遮罩调整)",Float)=1
        _flowStrength("_flowStrength(流动强度)", Float) = 0.25
        _Speed("_Speed(流动速度)", Float) = 0.5
        [Enum(One,1,SrcAlpha,5)] _SrcBlend ("_SrcBlend(混合模式SrcBlend)", Float) = 5
        [Enum(One,1,OneMinusSrcAlpha,10)] _DstBlend ("_DstBlend(混合模式DstBlend)", Float) = 10
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", int) = 0
		[Toggle]_ZWrite("ZWrite", Int) = 0

		[IntRange] _StencilID("Stencil ID", Range(0, 255)) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _CompareFunction("CompareFunction", int) = 8

    }
    SubShader
    {
        Tags 
        { 
            "Queue" = "Transparent" 
            "RenderType"="Transparent" 
            "CanUseSpriteAltas" = "True"
        }
		ZTest[_ZTest]
		ZWrite[_ZWrite]
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Blend [_SrcBlend] [_DstBlend] 

			Stencil
			{
				Ref[_StencilID]
				Comp [_CompareFunction]
				Pass Replace
				Fail Keep
			}


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

            sampler2D _MainTex,_Flowmap,_MaskTex;
			//CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float _flowStrength,_Speed,_MaskSmoothstepMin,_MaskSmoothstepMax;
				fixed4 _Color;
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

            float FlowStep1 = frac(_Time.y*_Speed);
            float FlowStep2 = frac(_Time.y*_Speed+0.5);
        	float4 sFlowmap1 = tex2D(_Flowmap, i.uv);
            float2 Flowmap1 = sFlowmap1.rg;
            Flowmap1= (Flowmap1-0.5)*float2(-1,-1)*_flowStrength;
            float2 Flow1Step1UV = FlowStep1*Flowmap1+i.uv;
            float2 Flow1Step2UV = FlowStep2*Flowmap1+i.uv;
            float4 sFlow1Step1 =  tex2D(_MainTex, Flow1Step1UV);
            float4 sFlow1Step2 = tex2D(_MainTex, Flow1Step2UV);
            float4 Flow1 = lerp(sFlow1Step1,sFlow1Step2,abs((FlowStep1-0.5)*2));  

            float4 MaskTex_color = tex2D(_MaskTex,(i.uv));
            float Mask_Value = min(MaskTex_color.r, MaskTex_color.a);
            Mask_Value= smoothstep(_MaskSmoothstepMin,_MaskSmoothstepMax,Mask_Value);
            Flow1.a *= Mask_Value; 

			Flow1 *= i.vertexColor * _Color;
            
            return Flow1;

            }
            ENDCG
        }
    }
	CustomEditor "ShaderHelpUniversal"
}

// https://lilithgames.feishu.cn/wiki/wikcnNI1VcIbO5c5dO861DSVtst
// Ver 1.1 适配Stencil参数控制
Shader "UEP/Interface/UIOutlight"
{
    Properties
    {
        [PerRendererData] _MainTex ("_MainTex(主贴图)", 2D) = "white" {}
		[Header(Main)]
        [HDR]_MainColor ("_MainColor(颜色)", Color) = (1,1,1,1)

        [Space]
        [Toggle(UEP_VARIANT_1)] _isHardWidth ("_isHardWidth(硬边开关)", int) = 0
        _Width ("_HardWidth(透明区域宽度)", Range(0,1)) = 1

		//[Header(Breath)]
		//[Toggle(UEP_VARIANT_1)] _Breath("_Breath", Int) = 0
		//_BreathParam ("_BreathParam(x:速度,y:最小值,z:最大值)", vector) = (0,0,1,1)

		[Header(Setting)]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

		[Header(Clip)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001
		
        [Header(Stencil)]
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", int) = 8
        _Stencil ("Stencil ID", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", int) = 0
        [HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255
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
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull [_Cull]
        Lighting Off
        ZWrite [_ZWrite]
        ZTest [_ZTest]
        Blend [_SrcBlend] [_DstBlend]

        Pass
        {
            Name "UIDefaultEx"
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT 
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
			//#pragma shader_feature_local __ UEP_VARIANT_1					// breath 呼吸灯
			#pragma shader_feature_local __ UEP_VARIANT_1        // width 宽度(软硬切换)

            struct appdata_t
            {
                float4 vertex   : POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float4 texcoord  : TEXCOORD0;		//xy:uv zw:worldPosition
            };

            sampler2D _MainTex;
			//int _Breath;
			//CBUFFER_START(UnityPerMaterial)
			    fixed4 _MainColor;
                //fixed4 _BreathParam;
			    float4 _MainTex_ST;
			    //half _GammaRadio;
			    fixed _AlphaClipThreshold;
                float _Width;
			//CBUFFER_END
			fixed4 _TextureSampleAdd;
			float4 _ClipRect;


            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.texcoord.zw = v.vertex.xy;
                OUT.vertex = UnityObjectToClipPos(v.vertex);

                OUT.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

                OUT.color = v.color * _MainColor;

				return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
				// 遮罩
				#ifdef UNITY_UI_CLIP_RECT
					fixed out_alpha = UnityGet2DClipping(IN.texcoord.zw, _ClipRect);
					if(out_alpha < 0.001)
					{
						return 0;
					}
                #endif

				// 贴图采样
                float4 color = tex2D(_MainTex, IN.texcoord.xy) + _TextureSampleAdd;
                color *= IN.color;

				//// 呼吸灯
				//#ifdef UEP_VARIANT_1
				//	color.a *= lerp(_BreathParam.y, _BreathParam.z, sin(_Time.y * _BreathParam.x)*0.5+0.5);
				//#endif

				// 透明裁切
				#ifdef UNITY_UI_ALPHACLIP
					if(color.a < _AlphaClipThreshold)
						return 0;
                #endif

                // 软硬边控制
                #ifdef UEP_VARIANT_1
                    color.a = saturate(min(color.a - 1 + _Width * 2, color.a));
                    //color.a = step(_xxx, color.a);
                #else
                    color.a = step(1-_Width-0.01, color.a) * step(0.01, color.a);
                #endif
                return color;
            }
			ENDCG
        }
    }
	CustomEditor "ShaderEditorUniversal"
}

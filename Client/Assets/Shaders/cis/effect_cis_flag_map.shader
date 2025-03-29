// https://lilithgames.feishu.cn/wiki/wikcniIdAnbgcinlQP4xkCVSmse
// Ver 1.0 igame旗帜icon换色shader
Shader "UEP/Interface/Flagmap"
{

    Properties
    {
        [PerRendererData] _MainTex ("_MainTex(主贴图)", 2D) = "white" {}
		[Header(Main)]
        _FlagMainTexture ("_FlagMainTexture", 2D) = "white" {}
        _FlagMainColor ("FlagMainColorA", Color) = (0.254, 0.327, 0.299, 1)
        _FlagDarkColor ("FlagMainColorB", Color) = (0.254, 0.327, 0.299, 1)
        _FlagEdgeColor("_FlagEdgeColor", Color) = (0.254, 0.327, 0.0, 1)
        _GradientColorA("_GradientColorA", Color) = (0,0,0,0)
        _GradientColorB("_GradientColorB", Color) = (0,0,0,0)
        _FlagGradientParam("_FlagGradientParam",Vector) = (0,1,0,1)
        _OutLineColor ("_OutLineColor(描边颜色)", Color) = (0.5, 0.5, 0.5, 1)
		_AlphaClipThreshold("_AlphaClipThreshold(裁切值)", Float) = 0.001

        [Space]
		[Header(Setting)]
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

		
        [Header(Stencil)]
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
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
            Name "Flagmap"
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

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
                float4 texcoord  : TEXCOORD0;		//xy:uv zw:_FlagMainTexture_ST
                float2 rectPosition : TEXCOORD1;
                half4  mask : TEXCOORD2;
            };

            sampler2D _MainTex,_FlagMainTexture;
			fixed4 _MainColor,_FlagMainColor,_FlagDarkColor,_OutLineColor,_FlagEdgeColor,_GradientColorA,_GradientColorB,_FlagGradientParam;
            fixed4 _FlagMainTexture_ST;
			fixed _AlphaClipThreshold;

			float4 _ClipRect;
            float _UIMaskSoftnessX;
            float _UIMaskSoftnessY;
            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.vertex = UnityObjectToClipPos(v.vertex);
                OUT.texcoord.zw = v.texcoord*_FlagMainTexture_ST.xy+_FlagMainTexture_ST.zw;

                float2 pixelSize = OUT.vertex.w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));
                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                OUT.rectPosition.xy = maskUV.xy;
                OUT.texcoord.xy = v.texcoord;
                OUT.mask = half4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));
                OUT.color = v.color ;

				return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                IN.color.a *= m.x * m.y;
                #endif

				// 贴图采样
                half4 frame = tex2D(_MainTex, IN.texcoord.xy);
                clip(frame.a - _AlphaClipThreshold);//画边缘
                half4 color = tex2D(_FlagMainTexture, IN.texcoord.zw);
                float gradientRangeA = smoothstep(_FlagGradientParam.x+_FlagGradientParam.y,_FlagGradientParam.x,IN.texcoord.y);//渐变颜色A
                float gradientRangeB = smoothstep(_FlagGradientParam.z+_FlagGradientParam.w,_FlagGradientParam.z,IN.texcoord.y);//渐变颜色B
                half3 outcolor = lerp(_FlagMainColor.rgb,_FlagDarkColor.rgb,color.r*_FlagDarkColor.a); 
                outcolor = lerp(outcolor,_GradientColorA*outcolor,gradientRangeA*_GradientColorA.w);
                outcolor = lerp(outcolor,lerp(_FlagEdgeColor,_GradientColorB*_FlagEdgeColor.rgb,gradientRangeB*_GradientColorB.w),frame.r); 
                outcolor = lerp(outcolor,_OutLineColor.rgb,frame.g);
                
                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                return half4(outcolor*IN.color.rgb,IN.color.a);

            }
			ENDCG
        }
    }
	CustomEditor "ShaderEditorUniversal"
}

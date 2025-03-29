// https://lilithgames.feishu.cn/wiki/R8Tzw98xeifqUWkA8llcZw9RnCb
// 分块高光
Shader "UEP/Interface/BlockFlash"
{
    Properties 
    {
        [Toggle] _NoVertexColor("_NoVertexColor", float) = 0
        _MainTex ("_MainTex(主贴图)", 2D) = "white" {}

        [HDR]_MainColor ("_MainColor(颜色)", Color) = (1,1,1,1)
        _Luminance("_Luminance(饱和度)",range(0,2)) = 1
        _UseExtraTex    ("使用底纹贴图", float) = 0
        _NoiseTex        ("_NoiseTex(底纹贴图)", 2D) = "white" {}
        _NoiseSpeedX     ("_NoiseSpeedX",float) = 0
        _NoiseSpeedY     ("_NoiseSpeedY",float) = 0
        [Toggle]_UsePolar   ("_UsePolar",float) = 0
        _PolarSpeedX     ("_PolarSpeedX",float) = 0
        _PolarSpeedY     ("_PolarSpeedY",float) = 0

		_BreathParam    ("_BreathParam(x:速度,y:最小值,z:最大值w:分区个数)", vector) = (1,0,1,3)
        _Threshold      ("_Threshold(分区阈值)", range(0,1)) = 0.5
        _BreathSpeed    ("_BreathSpeed(x:A通道速度, y:A通道速度, z:A通道速度, w:A通道速度)", vector) = (1, 1, 1, 1)
        _DivideMask     ("_DivideMask(分区贴图)", 2D) = "white" {}
        _DivideNumber   ("_DivideNumber(分区个数)", float) = 1

        _MaxColor("_MaxColor(最大颜色值)",range(0,2)) = 2
		[KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
		[Toggle]_ZWrite("ZWrite(深度写入)", int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 2

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
		_AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

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
            "Queue"             = "Transparent"
            "IgnoreProjector"   = "True"
            "RenderType"        = "Transparent"
            "PreviewType"       = "Plane"
            "CanUseSpriteAtlas" = "True"
        }

        Stencil
        {
            Ref         [_Stencil]
            Comp        [_StencilComp]
            Pass        [_StencilOp]
            ReadMask    [_StencilReadMask]
            WriteMask   [_StencilWriteMask]
        }

        Cull        [_Cull]
        Lighting    Off
        ZWrite      [_ZWrite]
        ZTest       [_ZTest]
        Blend       [_SrcBlend] [_DstBlend]

        Pass
        {
            Name "UIStars"
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
            #pragma shader_feature_local __ UEP_VARIANT_1       //极坐标
            #pragma shader_feature_local __ UEP_VARIANT_2       //不使用顶点色

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
                float4 texcoord  : TEXCOORD0;		
                float2 uv1      : TEXCOORD1;
                float2 uv2      : TEXCOORD2;
            };

            sampler2D _MainTex, _DivideMask, _NoiseTex;
			float4 _MainColor ,_BreathParam, _BreathSpeed;
			float4 _NoiseTex_ST, _DivideMask_ST;
			fixed _AlphaClipThreshold, _MaxColor;

			float4 _ClipRect;
            float  _DivideNumber,  _UseExtraTex;
            float  _NoiseSpeedX,  _NoiseSpeedY;
            float  _PolarSpeedX,  _PolarSpeedY;
            float  _Threshold, _Luminance;

            float2 Unity_PolarCoordinates_float(float2 UV, float RadialScale, float RadialOffset, float LengthScale, float LengthOffset)
            {
                float2 delta = UV - float2(0.5,0.5);
                float len = length(delta);
                float radius = len * 2 * RadialScale + RadialOffset;
                float angle = atan2(delta.x, delta.y) * 1.0 / 6.28 * LengthScale + LengthOffset;
                return float2(radius, angle);
            }

            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.texcoord.zw = v.vertex.xy;
                OUT.vertex = UnityObjectToClipPos(v.vertex);
                OUT.texcoord.xy = v.texcoord.xy;
                OUT.uv1 = TRANSFORM_TEX(v.texcoord.xy, _NoiseTex);
                OUT.uv2 = TRANSFORM_TEX(v.texcoord.xy, _DivideMask);
                OUT.color = v.color;
            #ifdef UEP_VARIANT_2
                OUT.color = 1;
            #endif 
                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
				#ifdef UNITY_UI_CLIP_RECT
					fixed out_alpha = UnityGet2DClipping(IN.texcoord.zw, _ClipRect);
					if(out_alpha < 0.001)
					{
						return 0;
					}
                #endif

                half4 color = tex2D(_MainTex, IN.texcoord.xy);

                float2 uv2;

                #ifdef UEP_VARIANT_1
                    uv2 = Unity_PolarCoordinates_float(IN.texcoord.xy, _NoiseTex_ST.x, _NoiseTex_ST.z + _PolarSpeedX * _Time.y, _NoiseTex_ST.y, _NoiseTex_ST.w + _PolarSpeedY * _Time.y);
                #else
                    uv2 = IN.uv1 + _Time.y * float2(_NoiseSpeedX, _NoiseSpeedY);
                #endif

                half4 tex = tex2D(_NoiseTex, uv2);

                color.w = tex.r * _UseExtraTex + (1 - _UseExtraTex) * color.w;

                half4 region = tex2D(_DivideMask, IN.uv2);


                color *= IN.color;
                color *= _MainColor;

                half luminance = 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
                half3 luminanceColor = half3(luminance, luminance, luminance);
                color.rgb =saturate( lerp(luminance, color.rgb, _Luminance));

                float rw = 1 / _BreathParam.w;

                //float timeR = _BreathParam.x / _BreathSpeed.x;
                //float timeG = _BreathParam.x / _BreathSpeed.y;
                //float timeB = _BreathParam.x / _BreathSpeed.z;
                //float timeA = _BreathParam.x / _BreathSpeed.w;

                float mainTime = _Time.y * _BreathParam.x;
                float rpR = mainTime % _BreathSpeed.x;
                float rpG = (mainTime + _BreathSpeed.y * rw )     % _BreathSpeed.y;
                float rpB = (mainTime + _BreathSpeed.y * rw * 2 ) % _BreathSpeed.z;
                float rpA = (mainTime + _BreathSpeed.y * rw * 3 ) % _BreathSpeed.w;

                float pR = rpR / _BreathSpeed.x;
                float pG = rpG / _BreathSpeed.y;
                float pB = rpB / _BreathSpeed.z;
                float pA = rpA / _BreathSpeed.w;

                float isR = step(1, _BreathParam.w);
                float isG = step(2, _BreathParam.w);
                float isB = step(3, _BreathParam.w);
                float isA = step(4, _BreathParam.w);
                //float isR = smoothstep(0,1, _BreathParam.w);
                //float isG = smoothstep(1,2, _BreathParam.w);
                //float isB = smoothstep(2,3, _BreathParam.w);
                //float isA = smoothstep(3,4, _BreathParam.w);

                //float isShineR = step(2, step(0,        pR) + step(pR, rw));
                //float isShineG = step(2, step(rw,       pG) + step(pG, rw * 2));
                //float isShineB = step(2, step(rw * 2,   pB) + step(pB, rw * 3));
                //float isShineA = step(2, step(rw * 3,   pA) + step(pA, rw * 4));

                //float isShine = region.x * isShineR + region.y * isShineG + region.z * isShineB + region.w * isShineA;

                //pR = _BreathParam.w * pR;
                //pG = _BreathParam.w * (pG - rw);
                //pB = _BreathParam.w * (pB - rw * 2);
                //pA = _BreathParam.w * (pA - rw * 3);

                // return isB;

                //float progress = saturate(step(_Threshold, region.x) * pR * isR 
                //                        + step(_Threshold, region.y) * pG * isG 
                //                        + step(_Threshold, region.z) * pB * isB
                //                        + step( region.w, _Threshold) * pA * isA );

                float progress_x = smoothstep(_BreathParam.y, _BreathParam.z, sin(pR * isR * 3.14) * region.x);
                float progress_y = smoothstep(_BreathParam.y, _BreathParam.z, sin(pG * isG * 3.14) * region.y);
                float progress_z = smoothstep(_BreathParam.y, _BreathParam.z, sin(pB * isB * 3.14) * region.z);
                float progress_w = smoothstep(_BreathParam.y, _BreathParam.z, sin(pA * isA * 3.14) * region.w);
                float progress_final = saturate(progress_x + progress_y + progress_z + progress_w);

                color.a *= progress_final;

                return color;
            }
			ENDCG
        }
    }
	CustomEditor "BlockFlashShaderGUI"
} 
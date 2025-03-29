// https://lilithgames.feishu.cn/wiki/wikcnQpvsWhUSbdPUDscoOV3dsg
//ver 2.2 Keyword调整
//written by YuXiang
//2022.04.13
//Dissolve Edge

Shader "UEP/Interface/DissolveEdge"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}

        _Fraction ("_Fraction(去色百分比)", Range(0, 1)) = 0
        _Color ("_Color(图片底色RGB)",color) = (1,1,1,1)
        _DissolveMask("_DissolveMask(遮罩图)", 2D) = "" {}
        _Dissolve("_Dissolve(主贴图溶解)", Range( 0 , 1)) = 1
        [NoScaleOffset]_EdgeTex("_EdgeTex(溶解贴图)", 2D) = "" {}

        [HDR]_EdgeColor ("_EdgeColor(边线颜色RGB)" , COLOR) = (1,1,1,1)
        _EdgeParam ("_EdgeParam(x:边线溶解进度 y:边线溶解软边 z:边线溶解宽度 w:/)", Vector) = (0,0,0,0)
        
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask ("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask ("Stencil Read Mask", Float) = 255

        //[HideInInspector]_ColorMask ("Color Mask", Float) = 15

        [Toggle(UEP_VARIANT_1)]_Mask("_Mask", int) = 0
        [Toggle(UEP_VARIANT_2)]_Edge("_Edge(需要同时开启_Mask)", int) = 0

        //[HideInInspector][Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("_UseUIAlphaClip", Float) = 0
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

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        //ColorMask [_ColorMask]

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            
            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma shader_feature_local __ UEP_VARIANT_1		//_Mask
            #pragma shader_feature_local __ UEP_VARIANT_2		//_Edge

            struct appdata_t
            {
                half4 vertex   : POSITION;
                half2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                half4 vertex   : SV_POSITION;
                half2 texcoord  : TEXCOORD0;
                half2 worldPosition : TEXCOORD1;
                #ifdef UEP_VARIANT_1
                    fixed2 uvdissolve : TEXCOORD12;
                #endif
            };

            sampler2D _MainTex;
			#ifdef UEP_VARIANT_1
				sampler2D _DissolveMask;
			#endif
			#ifdef UEP_VARIANT_2
				sampler2D _EdgeTex;
			#endif
			//CBUFFER_START(UnityPerMaterial)
				half4 _MainTex_ST,_DissolveMask_ST;
				fixed3 _EdgeColor,_EdgeParam;
				//uniform half4 _MainTex_TexelSize;
				half3 _Color;
				fixed _Fraction,_Dissolve;
			//CBUFFER_END
			fixed4 _ClipRect;

            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.worldPosition = v.vertex.xy;
                OUT.vertex = UnityObjectToClipPos(v.vertex);

                OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                #ifdef UEP_VARIANT_1
                    OUT.uvdissolve = TRANSFORM_TEX(v.texcoord, _DissolveMask);
                #endif      
                
                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
				#ifdef UNITY_UI_CLIP_RECT
					fixed _clip = UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
					if(_clip < 0.001)
					{
						return 0;
					}
				#endif
                
                half4 color = tex2D(_MainTex, IN.texcoord );
				#ifdef UEP_VARIANT_2
					float _EdgeImage = tex2D(_EdgeTex,IN.texcoord);
				#endif

                //#ifdef UNITY_UI_ALPHACLIP
                //    clip (color.a - 0.001);
                //#endif
                
                half3 _DesaturationColor = half4(0.3, 0.59, 0.11, 0);
                half3 _ColorDes = (1-_Fraction) * (dot(_DesaturationColor, color.rgb)) + _Fraction * color.rgb * _Color;

                #ifdef UEP_VARIANT_1

                    fixed mask = tex2D(_DissolveMask, IN.uvdissolve);
                    half3 color_mask = lerp(_ColorDes,color.rgb,saturate( ( mask + 1.0 + ( _Dissolve * -2.0 ) ) ));

                    #ifdef UEP_VARIANT_2

                        fixed dis_edge_big = smoothstep( _EdgeParam.x - _EdgeParam.z  , _EdgeParam.x + _EdgeParam.y , (1-mask));
                        fixed dis_edge_small = smoothstep( _EdgeParam.x, _EdgeParam.x + _EdgeParam.y , (1-mask));
                        fixed dis_edge = saturate(dis_edge_big - dis_edge_small) * _EdgeImage ;
						
                        return half4(saturate(color_mask + dis_edge * _EdgeColor.xyz),color.a);
                    #endif

                    return half4(color_mask,color.a);

                #endif                

                return half4(_ColorDes,color.a);
                
            }
            ENDCG
        }
    }
	CustomEditor "ShaderHelpUniversal"
}
